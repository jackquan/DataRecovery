//
//  FilesTypeObj.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "FilesTypeObj.h"
#import "AppDelegate.h"
#import "Define.h"

@implementation FilesTypeObj
@synthesize types;
@synthesize itunesDataRecoveryViewController;

- (id)init
{
    self = [super init];
    if (self) {
        types = nil;
    }
    return self;
}

- (void)dealloc
{
    [types release];
    [super dealloc];
}

#pragma mark tableView dataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.types.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *str = [[[types objectAtIndex:row] objectForKey:@"fileTitle"] lastPathComponent];
    int count = [[[types objectAtIndex:row] objectForKey:@"count"] intValue];
    if ([str isEqualToString:ADDRESSBOOKTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", ADDRESSBOOKTITLE, count];
    }
    else if ([str isEqualToString:SAFARITITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", SAFARITITLE, count];
    }
    else if ([str isEqualToString:CALLHISTORYTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", CALLHISTORYTITLE, count];
    }
    else if ([str isEqualToString:NOTESTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", NOTESTITLE, count];
    }
    else if ([str isEqualToString:IMAGESTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", IMAGESTITLE, count];
    }
    else if ([str isEqualToString:VIDIOSTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", VIDIOSTITLE, count];
    }
    else if ([str isEqualToString:BACKUPFILESTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", BACKUPFILESTITLE, count];
    }
    else if ([str isEqualToString:CALENDARTITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", CALENDARTITLE, count];
    }
    else if ([str isEqualToString:MESSAGETITLE]) {
        return [NSString stringWithFormat:@"%@ (%d)", MESSAGETITLE, count];
    }
    return nil;
}

#pragma mark tableView delegate
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    NSDictionary *dic = [types objectAtIndex:row];
    NSArray *infos = [dic objectForKey:@"infos"];
    NSString *title = [dic objectForKey:@"fileTitle"];
    
    [[NSApp delegate] selectFileTypePath:title mediasOrInfos:infos];
    
    return YES;
}

//- (void)tableViewSelectionDidChange:(NSNotification *)notification
//{
//    [[NSApp delegate] judgeToolItemEnable];
//}

@end
