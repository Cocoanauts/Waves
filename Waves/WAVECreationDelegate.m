//
//  WAVECreationDelegate.m
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECreationDelegate.h"

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

+ (NSString *)sanitizeApplicationName:(NSString *)appName
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

        if (charIndex > 0 && asciiCode == 32) {
        	asciiCode = [appName characterAtIndex:charIndex-1];
        	if (asciiCode != 32) {
        		[mutableString appendString:[NSString stringWithFormat:@"%C", unicodeCharacter]];
        	}
        }
    }
    NSString *newAppName = [NSString stringWithFormat:@"%@.app", mutableString];
    return newAppName;
}

#pragma mark Interface builder actions

- (IBAction)create:(id)sender
{
	NSLog(@"name: %@", self.name);
	NSLog(@"url: %@", self.url);
}

#pragma mark Window Delegate

- (void)windowDidBecomeMain:(NSNotification *)notification
{
	NSLog(@"window became main");
}

@end
