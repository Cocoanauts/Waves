//
//  WAVEWebViewDelegate.m
//  WaveApp
//
//  Created by Christoffer Winterkvist on 06/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEWebViewDelegate.h"

@interface WAVEWebViewDelegate ()
@end

@implementation WAVEWebViewDelegate

static NSString * const kMainURL = @"http://www.facebook.com/messages";

- (void)awakeFromNib
{
    self.webView.frameLoadDelegate = self;
    [self.webView setAcceptsTouchEvents:YES];
	[self.webView setMainFrameURL:kMainURL];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    DOMDocument *domDocument = [sender mainFrameDocument];    
    DOMElement *styleElement = [domDocument createElement:@"style"];
    [styleElement setAttribute:@"type" value:@"text/css"];
    
    NSString *string = [NSString stringWithFormat:@"#fbDockChatBuddylistNub,"
                                                    "#pagelet_bluebar,"
                                                    "#leftColContainer,"
                                                    "#rightCol,"
                                                    "#headerArea,"
                                                    "._2nd,"
                                                    "._3j5,"
                                                    "#pagelet_chat { display: none !important; }"
                                                    "#pagelet_group_mall { padding: 0px 5px !important; }"
                                                    ".storyContent .uiUfi { width: 100% !important; }"];
    
    DOMText *cssText = [domDocument createTextNode:string];
    [styleElement appendChild:cssText];
    DOMElement *headElement = (DOMElement*)[[domDocument getElementsByTagName:@"head"] item:0];
    [headElement appendChild:styleElement];
}

@end