//
//  WAVEWebView.h
//  WaveApp
//
//  Created by Christoffer Winterkvist on 14/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WAVEWebView : WebView

@property (nonatomic, retain) NSMutableDictionary *gestures;

- (BOOL)acceptsFirstResponder;
- (BOOL)twoFingerGestures;
- (void)beginGestureWithEvent:(NSEvent *)event;
- (void)endGestureWithEvent:(NSEvent *)event;

@end
