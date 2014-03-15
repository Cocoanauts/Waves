//
//  WAVEGeneralPreferencesViewController.m
//  WaveApp
//
//  Created by Elvis Nunez on 3/15/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEGeneralPreferencesViewController.h"

@interface WAVEGeneralPreferencesViewController ()

@end

@implementation WAVEGeneralPreferencesViewController

- (id)init
{
    return [super initWithNibName:@"WAVEGeneralPreferencesView" bundle:nil];
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"General", @"Toolbar item name for the General preference pane");
}

@end