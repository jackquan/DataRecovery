//
//  AppDelegate.h
//  DataRecovery
//
//  Created by 全晖林 on 14-7-7.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MainUIViewController1.h"

#import "iTunesDataRecoveryViewController.h"

#import "Data.h"

@class Data;
@class iTunesDataRecoveryViewController;
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    MainUIViewController1 *mainUIViewController;//DisplayData View
    
    iTunesDataRecoveryViewController *itunesDataRecoveryViewController;
    
    Data *data;
    
    
    
}

@property (assign) IBOutlet NSWindow *window;
@property (retain,readwrite) Data *data;

//第一视图控制层
@property (assign) IBOutlet NSView *view;//MainMenu.xib 最底层的视图
@property (assign) IBOutlet NSView *nsView1;//设备连接，开始界面
@property (assign) IBOutlet NSView *nsView2;//取得数据，显示数据界面

////nsView1的3个子视图
//@property (assign) IBOutlet NSView *subView1OfView4;//设备连接时，下方主视图1
//@property (assign) IBOutlet NSView *subView2OfView4;//设备连接时，下方主视图2
//@property (assign) IBOutlet NSView *subView3OfView4;//设备连接时，下方主视图3

//响应扫描按钮事件
-(IBAction)StartScan:(id)sender;

//响应Home按钮事件
-(IBAction)Home:(id)sender;
@end
