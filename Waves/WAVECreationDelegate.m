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

static NSString * const kAppCreationDestination = @"/Applications";

@implementation WAVECreationDelegate

@synthesize name, url;

#pragma mark Class methods

#pragma mark Interface builder actions

- (IBAction)create:(id)sender
{
    if ([self.url isURL]) {
        NSString *waveAppPath = [NSString stringWithFormat:@"%@/WaveApp.app", [[NSBundle mainBundle] resourcePath]];
        NSString *applicationName = [self.name applicationFriendlyName];
        NSString *destination = [NSString stringWithFormat:@"%@/%@.app", kAppCreationDestination, applicationName];
        NSError *error;
        
        [[NSFileManager defaultManager] copyItemAtPath:waveAppPath toPath:destination error:&error];
        if (error) {
        	NSLog(@"error: %@", [error localizedDescription]);
        }
        
        NSString *bundleIdentifier = [NSString stringWithFormat:@"%@.%@", [[NSBundle mainBundle] bundleIdentifier], [self.name bundleIdentifierFriendly]];
        NSBundle *waveAppBundle = [NSBundle bundleWithPath:destination];
        [self writeMainURLToPlistUsingBundle:waveAppBundle];
        [self setBundleIdentifier:(NSString *)bundleIdentifier toBundle:waveAppBundle];
    }
}

- (void)setBundleIdentifier:(NSString *)bundleIdentifier toBundle:(NSBundle *)bundle
{
    NSString *plistPath = [[bundle bundlePath] stringByAppendingPathComponent:@"Contents/Info.plist"];
    NSLog(@"%@", plistPath);
    NSDictionary *preferencesPlist = [NSDictionary wave_openPlistAtPath:plistPath];
    [preferencesPlist setValue:bundleIdentifier forKey:@"CFBundleIdentifier"];
    [preferencesPlist wave_save:plistPath];
}

- (void)writeMainURLToPlistUsingBundle:(NSBundle *)bundle
{
	NSString *plistPath = [bundle pathForResource:@"preferences" ofType:@"plist"];
	NSDictionary *preferencesPlist = [NSDictionary wave_openPlistAtPath:plistPath];
    [preferencesPlist setValue:self.url forKey:@"mainURL"];
    [preferencesPlist wave_save:plistPath];
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
