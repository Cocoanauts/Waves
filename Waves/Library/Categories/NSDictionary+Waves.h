//
//  NSDictionary+Waves.h
//  Waves
//
//  Created by Christoffer Winterkvist on 3/19/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Waves)

+ (NSDictionary *)wave_plistAtPath:(NSString *)path;
- (BOOL)wave_saveAtPath:(NSString *)path;

@end
