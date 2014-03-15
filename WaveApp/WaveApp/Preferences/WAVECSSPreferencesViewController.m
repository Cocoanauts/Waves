//
//  WAVECSSPreferencesViewController.m
//  WaveApp
//
//  Created by Elvis Nunez on 3/15/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECSSPreferencesViewController.h"

@interface WAVECSSPreferencesViewController ()

@end

@implementation WAVECSSPreferencesViewController

- (id)init
{
    return [super initWithNibName:@"WAVECSSPreferencesView" bundle:nil];
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"CSSPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameFontPanel];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"CSS", @"Toolbar item name for the CSS preference pane");
}

@end