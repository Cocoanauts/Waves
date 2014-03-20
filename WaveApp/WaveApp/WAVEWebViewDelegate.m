//
//  WAVEWebViewDelegate.m
//  WaveApp
//
//  Created by Christoffer Winterkvist on 06/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEWebViewDelegate.h"
#import "WAVEWebView.h"

@interface WAVEWebViewDelegate ()
@property (assign) IBOutlet WAVEWebView *webView;
@property (nonatomic, strong) NSDictionary *preferencesDict;
@end

@implementation WAVEWebViewDelegate

- (NSDictionary *)preferencesDict
{
    if (_preferencesDict) {
        return _preferencesDict;
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"preferences" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    _preferencesDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!_preferencesDict) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    return _preferencesDict;
}

- (void)awakeFromNib
{
    self.webView.frameLoadDelegate = self;
    self.webView.policyDelegate = self;
    self.webView.acceptsTouchEvents = YES;
    NSString *mainURL = [self.preferencesDict objectForKey:@"mainURL"];
    self.webView.mainFrameURL = mainURL;
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    DOMDocument *domDocument = [sender mainFrameDocument];    
    DOMElement *styleElement = [domDocument createElement:@"style"];
    [styleElement setAttribute:@"type" value:@"text/css"];

    NSString *string = [self.preferencesDict objectForKey:@"CSS"];
    DOMText *cssText = [domDocument createTextNode:string];
    [styleElement appendChild:cssText];
    DOMElement *headElement = (DOMElement*)[[domDocument getElementsByTagName:@"head"] item:0];
    [headElement appendChild:styleElement];
}


#pragma mark Policy delegate

- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
    if ([sender isEqual:self.webView]) {
        [listener use];
    }
}

- (void)webView:(WebView *)sender decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id<WebPolicyDecisionListener>)listener
{
    [[NSWorkspace sharedWorkspace] openURL:[actionInformation objectForKey:WebActionOriginalURLKey]];
    [listener ignore];
}

@end