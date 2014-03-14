//
//  WAVEWebViewDelegate.m
//  WaveApp
//
//  Created by Christoffer Winterkvist on 06/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEWebViewDelegate.h"

@implementation WAVEWebViewDelegate

static NSString * const kMainURL = @"http://www.facebook.com/messages";

@synthesize webView;

- (void)awakeFromNib
{
    [self.webView setAcceptsTouchEvents:YES];
	[self.webView setMainFrameURL:kMainURL];
}

@end
