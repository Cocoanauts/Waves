//
//  NSString+Waves.m
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "NSString+Waves.h"

@implementation NSString (Waves)

- (BOOL)waves_isURL
{
    NSURL *appURL = [NSURL URLWithString:self];
    if (appURL) {
    	return YES;
    }
	return NO;
}

- (NSString *)waves_applicationFriendlyName
{
	NSRange uppercaseCharacterRange = NSMakeRange(65, 90-65+1);
    NSRange lowercaseCharacterRange = NSMakeRange(97, 122-97+1);
    NSRange latinCharacterRange = NSMakeRange(192, 255-192+1);
    NSMutableString *mutableString = [[NSMutableString alloc] init];

    NSUInteger asciiCode;
    unichar unicodeCharacter;

    for (NSUInteger charIndex=0; charIndex<self.length; ++charIndex) {
        unicodeCharacter = [self characterAtIndex:charIndex];
        asciiCode = unicodeCharacter;

        if (NSLocationInRange(asciiCode, uppercaseCharacterRange)
        ||  NSLocationInRange(asciiCode, lowercaseCharacterRange)
        ||  NSLocationInRange(asciiCode, latinCharacterRange)) {
        	[mutableString appendString:[NSString stringWithFormat:@"%C", unicodeCharacter]];
        }
        if (charIndex > 0 && asciiCode == 32) {
        	asciiCode = [self characterAtIndex:charIndex-1];
        	if (asciiCode != 32) {
        		[mutableString appendString:[NSString stringWithFormat:@"%C", unicodeCharacter]];
        	}
        }
    }
    return [NSString stringWithFormat:@"%@", mutableString];
}

- (NSString *)waves_bundleIdentifierFriendly
{
	return [[self waves_applicationFriendlyName] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
