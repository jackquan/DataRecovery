//
//  MainUIViewController1.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-2.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MainUIViewController1 : NSViewController<NSOutlineViewDataSource,NSOpenSavePanelDelegate,NSMenuDelegate>
{

@private
    IBOutlet NSSplitView *nsSplitView;
    IBOutlet NSView *_mainContentView;
    NSArray *_topLevelItems;
    NSViewController *_currentContentViewController;
    NSMutableDictionary *_childrenDictionary;
    IBOutlet NSOutlineView *_sidebarOutlineView;
    

}

//@property(assign)IBOutlet NSWindow *mainUINSView;
@property(assign)IBOutlet NSSplitView *nsSplitView;


-(IBAction)sidebarMenuDidChange:(id)sender;


@end
