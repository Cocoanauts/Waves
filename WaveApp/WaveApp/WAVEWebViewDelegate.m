//
//  WAVEWebViewDelegate.m
//  WaveApp
//
//  Created by Christoffer Winterkvist on 06/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEWebViewDelegate.h"

@implementation WAVEWebViewDelegate

static NSString * const kMainURL = @"http://www.facebook.com";

@synthesize webView;

- (void)awakeFromNib
{
    [self.webView setPolicyDelegate:self];
    [self.webView setAcceptsTouchEvents:YES];
	[self.webView setMainFrameURL:kMainURL];
}

#pragma mark Policy delegate

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
    if ([sender isEqual:self.webView]) {
        [listener use];
    }
}

- (void)webView:(WebView *)sender decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id<WebPolicyDecisionListener>)listener {
    [[NSWorkspace sharedWorkspace] openURL:[actionInformation objectForKey:WebActionOriginalURLKey]];
    [listener ignore];
}

@end
