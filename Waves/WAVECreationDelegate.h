//
//  WAVECreationDelegate.h
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAVECreationDelegate : NSObject <NSWindowDelegate>

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *location;

- (IBAction)create:(id)sender;

@end
