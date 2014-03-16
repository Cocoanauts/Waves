//
//  WAVEAppDelegate.m
//  Waves
//
//  Created by Christoffer Winterkvist on 05/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEAppDelegate.h"

@implementation WAVEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    [NSApp activateIgnoringOtherApps:YES];
    [self.window makeKeyAndOrderFront: nil];
    return YES;
}

@end
