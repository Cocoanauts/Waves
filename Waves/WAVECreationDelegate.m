//
//  WAVECreationDelegate.m
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECreationDelegate.h"
#import "NSString+Waves.h"

static NSString * const kAppBundleIdentifier = @"com.cocoanauts.WaveApp";
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
        
        NSString *bundleIdentifier = [NSString stringWithFormat:@"%@.%@", kAppBundleIdentifier, [self.name bundleIdentifierFriendly]];
        NSBundle *waveAppBundle = [NSBundle bundleWithPath:destination];
        [self writeMainURLToPlistUsingBundle:waveAppBundle];
        [self setBundleIdentifier:(NSString *)bundleIdentifier toBundle:waveAppBundle];
    }
}

- (void)setBundleIdentifier:(NSString *)bundleIdentifier toBundle:(NSBundle *)bundle
{
    NSError *error;
    NSString *plistPath = [[bundle bundlePath] stringByAppendingPathComponent:@"Contents/Info.plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *preferencesDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!preferencesDict) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    [preferencesDict setValue:bundleIdentifier forKey:@"CFBundleIdentifier"];
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:preferencesDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    } else {
        NSLog(@"Error in saveData: %@", error);
    }
}

- (void)writeMainURLToPlistUsingBundle:(NSBundle *)bundle
{
    NSError *error;
	NSString *plistPath = [bundle pathForResource:@"preferences" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *preferencesDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!preferencesDict) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    [preferencesDict setValue:self.url forKey:@"mainURL"];
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:preferencesDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    } else {
        NSLog(@"Error in saveData: %@", error);
    }
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
