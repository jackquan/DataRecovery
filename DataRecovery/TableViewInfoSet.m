//
//  TableViewInfoSet.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "TableViewInfoSet.h"

@implementation TableViewInfoSet

+ (void)addressBookTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"fname"] autorelease];
    [tableColumn1.headerCell setTitle:@"Name"];
    [tableColumn1 setWidth:100.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn3 = [[[NSTableColumn alloc] initWithIdentifier:@"company"] autorelease];
    [tableColumn3.headerCell setTitle:@"Company"];
    [tableColumn3 setWidth:120.0];
    [tableColumn3 setEditable:NO];
    [tableView addTableColumn:tableColumn3];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"number"] autorelease];
    [tableColumn2.headerCell setTitle:@"Phone"];
    [tableColumn2 setWidth:150.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
}

+ (void)safariTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"safariTitle"] autorelease];
    [tableColumn1.headerCell setTitle:@"Title"];
    [tableColumn1 setWidth:240.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"safariUrl"] autorelease];
    [tableColumn2.headerCell setTitle:@"URL"];
    [tableColumn2 setWidth:360.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
}

+ (void)callHistoryTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn = [[[NSTableColumn alloc] initWithIdentifier:@"callName"] autorelease];
    [tableColumn.headerCell setTitle:@"Name"];
    [tableColumn setWidth:80.0];
    [tableView addTableColumn:tableColumn];
    
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"callPhone"] autorelease];
    [tableColumn1.headerCell setTitle:@"Phone"];
    [tableColumn1 setWidth:130.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"callDate"] autorelease];
    [tableColumn2.headerCell setTitle:@"Date"];
    [tableColumn2 setWidth:160.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
    
    NSTableColumn *tableColumn3 = [[[NSTableColumn alloc] initWithIdentifier:@"callType"] autorelease];
    [tableColumn3.headerCell setTitle:@"Type"];
    [tableColumn3 setWidth:80.0];
    [tableColumn3 setEditable:NO];
    [tableView addTableColumn:tableColumn3];
    
    NSTableColumn *tableColumn4 = [[[NSTableColumn alloc] initWithIdentifier:@"callDuration"] autorelease];
    [tableColumn4.headerCell setTitle:@"Duration"];
    [tableColumn4 setWidth:180.0];
    [tableColumn4 setEditable:NO];
    [tableView addTableColumn:tableColumn4];
}

+ (void)noteTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"title"] autorelease];
    [tableColumn1.headerCell setTitle:@"Title"];
    [tableColumn1 setWidth:120.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"date"] autorelease];
    [tableColumn2.headerCell setTitle:@"Date"];
    [tableColumn2 setWidth:200.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
    
    NSTableColumn *tableColumn3 = [[[NSTableColumn alloc] initWithIdentifier:@"content"] autorelease];
    [tableColumn3.headerCell setTitle:@"Content"];
    [tableColumn3 setEditable:NO];
    [tableView addTableColumn:tableColumn3];
}

+ (void)calendarTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"cal_title"] autorelease];
    [tableColumn1.headerCell setTitle:@"Title"];
    [tableColumn1 setWidth:150.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"cal_list"] autorelease];
    [tableColumn2.headerCell setTitle:@"List"];
    [tableColumn2 setWidth:120.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
    
    NSTableColumn *tableColumn3 = [[[NSTableColumn alloc] initWithIdentifier:@"cal_status"] autorelease];
    [tableColumn3.headerCell setTitle:@"Status"];
    [tableColumn3 setEditable:NO];
    [tableView addTableColumn:tableColumn3];
}

+ (void)messageTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"msg_name"] autorelease];
    [tableColumn1.headerCell setTitle:@"Name"];
    [tableColumn1 setWidth:200.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
    
    NSTableColumn *tableColumn2 = [[[NSTableColumn alloc] initWithIdentifier:@"msg_phone"] autorelease];
    [tableColumn2.headerCell setTitle:@"Phone"];
    [tableColumn2 setWidth:230.0];
    [tableColumn2 setEditable:NO];
    [tableView addTableColumn:tableColumn2];
}

+ (void)imageTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"image"] autorelease];
    [tableColumn1.headerCell setTitle:@"ImageName"];
    [tableColumn1 setWidth:602.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
}

+ (void)vedioTableViewSet:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"vedio"] autorelease];
    [tableColumn1.headerCell setTitle:@"VedioName"];
    [tableColumn1 setWidth:602.0];
    [tableColumn1 setEditable:NO];
    [tableView addTableColumn:tableColumn1];
}

+ (void)backupFilesLoad:(NSTableView *)tableView
{
    NSTableColumn *tableColumn1 = [[[NSTableColumn alloc] initWithIdentifier:@"filename"] autorelease];
    [tableColumn1.headerCell setTitle:@"FileName"];
    [tableColumn1 setEditable:NO];
    [tableColumn1 setWidth:802.0];
    [tableView addTableColumn:tableColumn1];
}


@end
