//
//  ConnectedDevicesController.h
//  DataRecovery
//
//  Created by 全晖林 on 14-7-8.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//ConnectedDevicesViewClass
#import "MyCustomView1.h"
#import "MyCustomView2.h"
#import "MyCustomView3.h"

@class MyCustomView1;
@class MyCustomView2;
@class MyCustomView3;

@interface ConnectedDevicesController : NSViewController
{
    //NSView *myCustomView4的3个子视图
    IBOutlet NSView *subView1OfView4;
    IBOutlet NSView *subView2OfView4;
    IBOutlet NSView *subView3OfView4;
    
}

//设备连接时的视图
@property (assign) IBOutlet MyCustomView1 *myCustomView1;
@property (assign) IBOutlet MyCustomView2 *myCustomView2;
@property (assign) IBOutlet MyCustomView3 *myCustomView3;
@property (assign) IBOutlet NSView *myCustomView4;

//NSView *myCustomView4的3个子视图
@property (assign) IBOutlet NSView *subView1OfView4;
@property (assign) IBOutlet NSView *subView2OfView4;
@property (assign) IBOutlet NSView *subView3OfView4;



@end
