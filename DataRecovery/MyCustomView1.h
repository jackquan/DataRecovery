//
//  MyCustomView1.h
//  DataRecovery
//
//  Created by 全晖林 on 14-7-7.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ConnectedDevicesController.h"


@class ConnectedDevicesController;

@interface MyCustomView1 : NSView
{
    ConnectedDevicesController *connectedDevicesController;
}

@property (retain) ConnectedDevicesController *connectedDevicesController;

@end
