//
//  AppDelegate.m
//  DataRecovery
//
//  Created by 全晖林 on 14-7-7.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "AppDelegate.h"
#import "Data.h"

@implementation AppDelegate

//第一视图控制层
@synthesize view;
@synthesize nsView1;
@synthesize nsView2;

@synthesize data;

//nsView1的3个子视图，设备连接时，下方的3个主视图
//@synthesize subView1OfView4;
//@synthesize subView2OfView4;
//@synthesize subView3OfView4;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
//    self.data=[[Data alloc]init];
//    
//    NSLog(@"数据 %ld",[self.data.photosData count]);

    
    [view addSubview:nsView1];
    
//    if(!mainUIViewController){
//        mainUIViewController=[[MainUIViewController1 alloc ]initWithNibName:@"MainUIViewController1" bundle:nil];
//    }
//        [view addSubview:[mainUIViewController view]];
//        
//        [[mainUIViewController view]setFrame:[view bounds]];
//    

}


//响应扫描按钮事件
-(IBAction)StartScan:(id)sender
{
    NSArray* subViews=[view subviews];
    
    for (int i = 0 ; i<[subViews count];i++)
    {
        [[subViews objectAtIndex:i] removeFromSuperview];
    }

//    if(!mainUIViewController){
//        mainUIViewController=[[MainUIViewController1 alloc ]initWithNibName:@"MainUIViewController1" bundle:nil];
//    }
//    [view addSubview:[mainUIViewController view]];
//    
//    [[mainUIViewController view]setFrame:[view bounds]];
    
    //将nsView2的Frame更新为view最新Frame
    [nsView2 setFrame:[view bounds]];
    
    [view addSubview:nsView2];
    
    //加载数据
    itunesDataRecoveryViewController=[[iTunesDataRecoveryViewController alloc]init];
    [itunesDataRecoveryViewController loadData];
    [itunesDataRecoveryViewController.photoData count];
    
}

//响应Home按钮事件
-(IBAction)Home:(id)sender
{
    
    
    
    NSArray* subViews=[view subviews];
    
    for (int i = 0 ; i<[subViews count];i++)
    {
        [[subViews objectAtIndex:i] removeFromSuperview];
    }
    
    //将nsView1的Frame更新为view最新Frame
    [nsView1 setFrame:[view bounds]];
    
    [view addSubview:nsView1];
    
    
}

@end
