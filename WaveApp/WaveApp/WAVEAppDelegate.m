//
//  WAVEAppDelegate.m
//  WaveApp
//
//  Created by Christoffer Winterkvist on 06/03/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEAppDelegate.h"
#import "MASPreferencesWindowController.h"
#import "WAVEGeneralPreferencesViewController.h"
#import "WAVECSSPreferencesViewController.h"

@interface WAVEAppDelegate ()
@property (nonatomic, strong) NSWindowController *preferencesWindowController;
@end

@implementation WAVEAppDelegate

#pragma mark - Lazy Initialization

- (NSWindowController *)preferencesWindowController
{
    if (_preferencesWindowController) {
        return _preferencesWindowController;
    }

    NSViewController *generalController = [[WAVEGeneralPreferencesViewController alloc] init];
    NSViewController *cssController = [[WAVECSSPreferencesViewController alloc] init];
    NSString *title = NSLocalizedString(@"Preferences", @"Title for Preferences Window");
    _preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:@[generalController, cssController] title:title];
    return _preferencesWindowController;
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    [NSApp activateIgnoringOtherApps:YES];
    [self.window makeKeyAndOrderFront: nil];
    return YES;
}

- (IBAction)openPreferences:(id)sender
{
    [self.preferencesWindowController showWindow:nil];
}

@end
