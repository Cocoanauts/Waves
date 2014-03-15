//
//  WAVECSSPreferencesViewController.m
//  WaveApp
//
//  Created by Elvis Nunez on 3/15/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVECSSPreferencesViewController.h"

@interface WAVECSSPreferencesViewController () <NSTextViewDelegate>
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation WAVECSSPreferencesViewController

- (id)init
{
    self = [super initWithNibName:@"WAVECSSPreferencesView" bundle:nil];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"preferences" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *preferencesDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (preferencesDict) {
        self.textView.string = [preferencesDict objectForKey:@"CSS"];
    }    
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

#pragma mark - NSTextViewDelegate

- (void)textDidChange:(NSNotification *)aNotification
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"preferences" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *preferencesDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!preferencesDict) {
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    [preferencesDict setValue:self.textView.string forKey:@"CSS"];
    
    NSString *error = nil;
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:preferencesDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    // check is plistData exists
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    } else {
        NSLog(@"Error in saveData: %@", error);
    }
}

@end