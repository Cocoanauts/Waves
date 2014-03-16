//
//  WAVEJavaScriptPreferencesViewController.m
//  WaveApp
//
//  Created by Elvis Nunez on 3/16/14.
//  Copyright (c) 2014 Hyper. All rights reserved.
//

#import "WAVEJavaScriptPreferencesViewController.h"

@interface WAVEJavaScriptPreferencesViewController () <NSTextViewDelegate>
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@end

@implementation WAVEJavaScriptPreferencesViewController

- (id)init
{
    self = [super initWithNibName:@"WAVEJavaScriptPreferencesView" bundle:nil];
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
        self.textView.string = [preferencesDict objectForKey:@"JavaScript"];
    }
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"JavaScriptPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"JavaScript", @"Toolbar item name for the JavaScript preference pane");
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
    [preferencesDict setValue:self.textView.string forKey:@"JavaScript"];
    
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