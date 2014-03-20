//
//  WAVECreationDelegate.m
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECreationDelegate.h"
#import "NSString+Waves.h"
#import "NSDictionary+Waves.h"

static NSString * const WAVEAppCreationDestination = @"/Applications";

@implementation WAVECreationDelegate

#pragma mark Interface builder actions

- (IBAction)create:(id)sender
{
    if ([self.url waves_isURL]) {
        NSString *waveAppPath = [NSString stringWithFormat:@"%@/WaveApp.app", [[NSBundle mainBundle] resourcePath]];
        NSString *applicationName = [self.name waves_applicationFriendlyName];
        NSString *destination = [NSString stringWithFormat:@"%@/%@.app", WAVEAppCreationDestination, applicationName];
        NSError *error = nil;
        BOOL didCopyItem = [[NSFileManager defaultManager] copyItemAtPath:waveAppPath toPath:destination error:&error];

        if (!didCopyItem) {
        	NSLog(@"error: %@", [error localizedDescription]);
        }
        
        NSString *bundleIdentifier = [NSString stringWithFormat:@"%@.%@", [[NSBundle mainBundle] bundleIdentifier], [self.name waves_bundleIdentifierFriendly]];
        NSBundle *waveAppBundle = [NSBundle bundleWithPath:destination];
        [self writeMainURLToPlistUsingBundle:waveAppBundle];
        [self setBundleIdentifier:(NSString *)bundleIdentifier toBundle:waveAppBundle];
    }
}

- (void)setBundleIdentifier:(NSString *)bundleIdentifier toBundle:(NSBundle *)bundle
{
    NSString *plistPath = [[bundle bundlePath] stringByAppendingPathComponent:@"Contents/Info.plist"];
    NSLog(@"%@", plistPath);
	NSDictionary *preferencesPlist = [NSDictionary wave_plistAtPath:plistPath];
    [preferencesPlist setValue:bundleIdentifier forKey:@"CFBundleIdentifier"];
    [preferencesPlist wave_saveAtPath:plistPath];
}

- (void)writeMainURLToPlistUsingBundle:(NSBundle *)bundle
{
	NSString *plistPath = [bundle pathForResource:@"preferences" ofType:@"plist"];
	NSDictionary *preferencesPlist = [NSDictionary wave_plistAtPath:plistPath];
    [preferencesPlist setValue:self.url forKey:@"mainURL"];
    [preferencesPlist wave_saveAtPath:plistPath];
}

- (void)awakeFromNib
{
    self.name = @"Facebook";
    self.url = @"http://www.facebook.com";
}

#pragma mark Window Delegate

- (void)windowDidBecomeMain:(NSNotification *)notification
{

}

@end
