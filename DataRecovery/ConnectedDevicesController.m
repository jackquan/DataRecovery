//
//  ConnectedDevicesController.m
//  DataRecovery
//
//  Created by 全晖林 on 14-7-8.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "ConnectedDevicesController.h"

@implementation ConnectedDevicesController

//设备连接时的视图
@synthesize myCustomView1;
@synthesize myCustomView2;
@synthesize myCustomView3;
@synthesize myCustomView4;

//NSView *myCustomView4的3个子视图
@synthesize subView1OfView4;
@synthesize subView2OfView4;
@synthesize subView3OfView4;

-(void)awakeFromNib
{
    //将这个ConnectedDevicesController实例化给 myCustomView1的
    //ConnectedDevicesController属性
    [myCustomView1 setConnectedDevicesController:self];
    
    [myCustomView2 setConnectedDevicesController:self];
    
    [myCustomView3 setConnectedDevicesController:self];
    
}

@end
