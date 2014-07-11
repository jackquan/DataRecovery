//
//  MyCustomView2.m
//  DataRecovery
//
//  Created by 全晖林 on 14-7-7.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "MyCustomView2.h"

@implementation MyCustomView2

@synthesize connectedDevicesController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        //添加跟踪区域
        [self addTrackingRect:self.bounds owner:self userData:nil assumeInside:YES];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    //设置填充颜色
    [[NSColor greenColor]set];
    NSRectFill(dirtyRect);
}

-(void)mouseDown:(NSEvent *)theEvent
{
    NSLog(@"响应鼠标事件2");
    NSArray *subViews=[connectedDevicesController.myCustomView4 subviews];
    
        for (int i=0; i<[subViews count]; i++) {
            [[subViews objectAtIndex:i] removeFromSuperview];
        }
    
    //myCustomView4 添加子视图 subView2OfView4
    [connectedDevicesController.myCustomView4 addSubview:connectedDevicesController.subView2OfView4];
    
    [connectedDevicesController.subView2OfView4 setFrame:[connectedDevicesController.myCustomView4 bounds]];
}
@end
