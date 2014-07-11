//
//  TableViewInfoSet.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface TableViewInfoSet : NSObject{

}


+ (void)addressBookTableViewSet:(NSTableView *)tableView;
+ (void)safariTableViewSet:(NSTableView *)tableView;
+ (void)callHistoryTableViewSet:(NSTableView *)tableView;
+ (void)noteTableViewSet:(NSTableView *)tableView;
+ (void)calendarTableViewSet:(NSTableView *)tableView;
+ (void)messageTableViewSet:(NSTableView *)tableView;
+ (void)imageTableViewSet:(NSTableView *)tableView;
+ (void)vedioTableViewSet:(NSTableView *)tableView;
+ (void)backupFilesLoad:(NSTableView *)tableView;


@end
