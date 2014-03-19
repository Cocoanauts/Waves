//
//  NSString+Waves.h
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Waves)

- (BOOL)waves_isURL;
- (NSString *)waves_applicationFriendlyName;
- (NSString *)waves_bundleIdentifierFriendly;

@end
