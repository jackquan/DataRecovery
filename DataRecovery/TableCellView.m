//
//  TableCellView.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-1.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "TableCellView.h"

@implementation TableCellView

@synthesize button=_button;


-(void)awakeFromNib
{
    [[self.button cell]setBezelStyle:NSInlineBezelStyle];
}

-(void)dealloc
{
    self.button=nil;
    [super dealloc];
}

-(void)viewWillDraw
{
    [super viewWillDraw];
    if (![self.button isHidden]) {
        [self.button sizeToFit];
        
        NSRect textFrame=self.textField.frame;
        NSRect buttonFrame=self.button.frame;
        buttonFrame.origin.x=NSWidth(self.frame)-NSWidth(buttonFrame);
        
        self.button.frame=buttonFrame;
        textFrame.size.width=NSMinX(buttonFrame)-NSMinX(textFrame);
        self.textField.frame=textFrame;
    }
}
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
