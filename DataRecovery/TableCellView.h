//
//  TableCellView.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-1.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableCellView : NSTableCellView
{
    @private
    NSButton *_button;
}

@property(retain)IBOutlet NSButton *button;

@end
