//
//  ImageBrowserViewController.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-3.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

#import "Data.h"
@class AppDelegate;
@class iTunesDataRecoveryViewController;
@interface ImageBrowserViewController : NSViewController
{
    iTunesDataRecoveryViewController *itunesDataRecoveryViewControllerApp;
    AppDelegate *app;
    IBOutlet IKImageBrowserView *_imageBrowser;
    NSMutableArray *images;
    NSMutableArray *importedImages;
    
    Data *data;
    
    IBOutlet NSView *nsview;
}

//-(IBAction)addFiles:(id)sender;
@property (retain)AppDelegate *app;

@property (retain,readwrite) Data *data;

@property (retain)iTunesDataRecoveryViewController *itunesDataRecoveryViewControllerApp;
@end
