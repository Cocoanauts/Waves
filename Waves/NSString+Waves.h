//
//  NSString+Waves.h
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Waves)

- (BOOL)isURL;
- (NSString *)applicationFriendlyName;
- (NSString *)bundleIdentifierFriendly;

@end
