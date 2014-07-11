//
//  iTunesDataRecoveryViewController.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ImageBrowserViewController.h"
#import "MyCustomView3.h"

@class FilesInfoViewObj;
@class FilesTypeObj;
@class AppDelegate;
@class MyCustomView3;

@interface iTunesDataRecoveryViewController : NSViewController<NSApplicationDelegate>
{
    AppDelegate *app;
    
    MyCustomView3 *myCustomView3;
    
    ImageBrowserViewController *imageBrowserViewController;
    
    iTunesDataRecoveryViewController *itunesDataRecoveryViewController;
    
       IBOutlet NSWindow *window;
    
    IBOutlet NSToolbar *myToolbar;
    IBOutlet NSToolbarItem *savePDFItem;
    IBOutlet NSToolbarItem *recoveryItem;
    IBOutlet NSSplitView *mySplitView;
    
    //media文件信息显示控件
    IBOutlet NSImageView *myImageView;
    IBOutlet NSTextField *name_label;
    IBOutlet NSTextField *size_label;
    //calendar文件信息显示控件
    IBOutlet NSTextField *title_label;
    IBOutlet NSTextField *descrip_label;
    
    //address 文件信息显示控件
    //    IBOutlet NSTextField *address_name_label;
    
    
    //所有设备以及备份路径
    NSArray *deviceArray;
    NSArray *backupPaths;
    
    //被排列好的左边的title数据
    NSArray *sortTypes;
    
    //所有信息显示总视图
    IBOutlet NSView *infoView;
    //文件信息scrollView子视图
    IBOutlet NSView *scrollView_chView;
    //文件信息子视图
    IBOutlet NSView *addressInfoView;
    IBOutlet NSView *mediaInfoView;
    IBOutlet NSView *messageView;
    IBOutlet NSView *calendarInfoView;
    //所有表格
    IBOutlet NSTableView *tableView_device;
    IBOutlet NSTableView *tableView_info;
    IBOutlet NSTableView *tableView_title;
    
    IBOutlet FilesInfoViewObj *filesInfoObj;
    FilesTypeObj *filesTypeObj;
    
    NSString *curDeviceName;
    
    IBOutlet NSWindow *progressWindow;
    float progressValue;
    float progressMaxValue;
    
    ///////////////------photo Data------/////////////////
    NSMutableArray *photoData;
}


@property (retain)IBOutlet NSSplitView *mySplitView;
@property (assign)AppDelegate *app;
@property (assign)ImageBrowserViewController *imageBrowserViewController;

@property (retain,readwrite) NSMutableArray *photoData;
@property (readonly) NSTableView *tableView_info;
@property (readonly) NSWindow *window;

@property (assign, nonatomic) float progressValue;
@property (assign, nonatomic) float progressMaxValue;

@property (retain, readwrite) NSArray *deviceArray;
@property (retain, readwrite) NSArray *backupPaths;

@property (retain, readwrite) NSString *curDeviceName;

@property (retain)MyCustomView3 *myCustomView3;
- (IBAction)startScanAction:(id)sender;

- (IBAction)barBackAction:(id)sender;
- (IBAction)barRecoveryAction:(id)sender;
- (IBAction)printAction:(id)sender;

- (void)addInfoView;
- (void)loadData;

- (void)selectFileTypePath:(NSString *)titleName mediasOrInfos:(NSArray *)medias;

- (void)selectFileInfo:(id)info title:(NSString *)titleName;
- (void)addLabelToAddressView:(NSDictionary *)info;
- (void)addBoxToMsgView:(NSArray *)msgInfos;

- (void)judgeToolItemEnable;


@end
