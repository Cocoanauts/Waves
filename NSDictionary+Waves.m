//
//  NSDictionary+Waves.m
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "NSDictionary+Waves.h"

@implementation NSDictionary (Waves)

+ (NSDictionary *)wave_plistAtPath:(NSString *)path
{
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:path];
    NSString *errorDescription = nil;
    NSPropertyListFormat format;
    NSDictionary *plistDictionary = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDescription];
    if (!plistDictionary) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDescription, format);
        return nil;
    }
	return plistDictionary;
}

- (BOOL)wave_saveAtPath:(NSString *)path
{
    NSString *errorDesc;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];
    
    if(plistData) {
        [plistData writeToFile:path atomically:YES];
    } else {
        NSLog(@"Error in saveData: %@", errorDesc);
        return NO;
    }
    return YES;
}

@end
