//
//  WAVECreationDelegate.m
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECreationDelegate.h"

static NSString * const kAppBundleIdentifier = @"com.cocoanauts.WaveApp";
static NSString * const kAppCreationDestination = @"/Applications";

@implementation WAVECreationDelegate

@synthesize name, url;

#pragma mark Class methods

+ (BOOL)validateURLUsingString:(NSString *)urlString
{
    NSURL *appURL = [NSURL URLWithString:urlString];
    if (appURL) {
    	return YES;
    }
	return NO;
}

+ (NSString *)sanitizeApplicationName:(NSString *)appName andAllowSpace:(BOOL)allowSpace
{
    NSRange uppercaseCharacterRange = NSMakeRange(65, 90-65+1);
    NSRange lowercaseCharacterRange = NSMakeRange(97, 122-97+1);
    NSRange latinCharacterRange = NSMakeRange(192, 255-192+1);
    NSMutableString *mutableString = [[NSMutableString alloc] init];

    int asciiCode;
    unichar unicodeCharacter;

    for (NSUInteger charIndex=0; charIndex<appName.length; ++charIndex) {
        unicodeCharacter = [appName characterAtIndex:charIndex];
        asciiCode = unicodeCharacter;

        if (NSLocationInRange(asciiCode, uppercaseCharacterRange)
        ||  NSLocationInRange(asciiCode, lowercaseCharacterRange)
        ||  NSLocationInRange(asciiCode, latinCharacterRange)) {
        	[mutableString appendString:[NSString stringWithFormat:@"%C", unicodeCharacter]];
        }
        if (allowSpace) {
            if (charIndex > 0 && asciiCode == 32) {
            	asciiCode = [appName characterAtIndex:charIndex-1];
            	if (asciiCode != 32) {
            		[mutableString appendString:[NSString stringWithFormat:@"%C", unicodeCharacter]];
            	}
            }
        }
    }
    NSString *newAppName = [NSString stringWithFormat:@"%@", mutableString];
    return newAppName;
}

#pragma mark Interface builder actions

- (IBAction)create:(id)sender
{
    if ([WAVECreationDelegate validateURLUsingString:self.url]) {
    	NSString *waveAppPath = [NSString stringWithFormat:@"%@/WaveApp.app", [[NSBundle mainBundle] resourcePath]];
        NSString *applicationName = [WAVECreationDelegate sanitizeApplicationName:self.name andAllowSpace:YES];
        NSString *destination = [NSString stringWithFormat:@"%@/%@.app", kAppCreationDestination, applicationName];
        NSError *error;

    	[[NSFileManager defaultManager] copyItemAtPath:waveAppPath toPath:destination error:&error];
        if (error) {
        	NSLog(@"error: %@", [error localizedDescription]);
        }

        NSString *bundleIdentifier = [NSString stringWithFormat:@"%@.%@", kAppBundleIdentifier, [WAVECreationDelegate sanitizeApplicationName:self.name andAllowSpace:NO]];
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
