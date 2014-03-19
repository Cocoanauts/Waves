//
//  NSDictionary+Waves.h
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Waves)

+ (NSDictionary *)wave_openPlistAtPath:(NSString *)path;
- (BOOL)wave_save:(NSString *)path;

@end
