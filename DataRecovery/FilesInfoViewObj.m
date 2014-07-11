//
//  FilesInfoViewObj.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//
#import "FilesInfoViewObj.h"
#import "AppDelegate.h"

@implementation FilesInfoViewObj
@synthesize infos;
@synthesize names;

@synthesize titleName;

- (id)init
{
    self = [super init];
    if (self) {
        infos = nil;
        names = nil;
        titleName = nil;
    }
    return self;
}

- (void)dealloc
{
    [infos release], [names release];
    [titleName release];
    [super dealloc];
}

- (NSString *)getPhoneName:(NSString *)number
{
    for (NSDictionary *dic in self.names) {
        NSString *phone = [dic objectForKey:@"number"];
        if ([number isEqualToString:phone]) {
            return [dic objectForKey:@"fname"];
        }
    }
    return @"--";
}

#pragma mark tableView dataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return infos.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *identify = [tableColumn identifier];
    if ([identify isEqualToString:@"fname"]) {
        NSString *name = [[infos objectAtIndex:row] objectForKey:@"fname"];
        return name;
    }
    else if ([identify isEqualToString:@"number"]){
        NSString *number = [[infos objectAtIndex:row] objectForKey:@"number"];
        if (number == nil) {
            return @"--";
        }
        return number;
    }
    else if ([identify isEqualToString:@"company"]){
        NSString *company = [[infos objectAtIndex:row] objectForKey:@"company"];
        if ((NSNull *)company == [NSNull null] || company == nil) {
            return @"--";
        }
        return company;
    }
    else if ([identify isEqualToString:@"title"]) {
        return [[infos objectAtIndex:row] objectForKey:@"ZTITLE"];
    }
    else if ([identify isEqualToString:@"date"]) {
        NSString *value = [[infos objectAtIndex:row] objectForKey:@"ZCREATIONDATE"];
        double dvalue = value.doubleValue;
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:dvalue];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:date];
    }
    else if ([identify isEqualToString:@"content"]) {
        return [[infos objectAtIndex:row] objectForKey:@"ZCONTENT"];
    }
    else if ([identify isEqualToString:@"callPhone"]) {
        return [[infos objectAtIndex:row] objectForKey:@"address"];
    }
    else if ([identify isEqualToString:@"callName"]) {
        NSString *callPhone = [[infos objectAtIndex:row] objectForKey:@"address"];
        return [self getPhoneName:callPhone];
    }
    else if ([identify isEqualToString:@"callDate"]) {
        NSString *value = [[infos objectAtIndex:row] objectForKey:@"date"];
        double dvalue = value.doubleValue;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:dvalue];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:date];
    }
    else if ([identify isEqualToString:@"callType"]) {
        NSString *flags = [[infos objectAtIndex:row] objectForKey:@"flags"];
        int flagValue = flags.intValue;
        if (flagValue == 5) {
            return @"Outgoing";
        }
        return @"Incoming";
    }
    else if ([identify isEqualToString:@"callDuration"]) {
        NSString *duration = [[infos objectAtIndex:row] objectForKey:@"duration"];
        NSString *flags = [[infos objectAtIndex:row] objectForKey:@"flags"];
        int flagValue = flags.intValue;
        int duraValue = duration.intValue;
        if (duraValue == 0) {
            if (flagValue == 5) {
                return @"Cancelled";
            }else {
                return @"Missed";
            }
        }
        else {
            if (duraValue<60) {
                return [NSString stringWithFormat:@"%d seconds", duraValue];
            }else if (duraValue>=60 && duraValue<3600) {
                return [NSString stringWithFormat:@"%d minutes %d seconds", duraValue/60, duraValue%60];
            }
            else {
                return [NSString stringWithFormat:@"%d hours %d minutes", duraValue/3600, duraValue%3600/60];
            }
        }
        return nil;
    }
    else if ([identify isEqualToString:@"safariTitle"]) {
        return [[infos objectAtIndex:row] objectForKey:@"title"];
    }
    else if ([identify isEqualToString:@"safariUrl"]) {
        NSString *url = [[infos objectAtIndex:row] objectForKey:@"url"];
        return url;
    }
    else if ([identify isEqualToString:@"image"]) {
        NSString *url = [[infos objectAtIndex:row] lastPathComponent];
        return url;
    }
    else if ([identify isEqualToString:@"vedio"]) {
        NSString *url = [[infos objectAtIndex:row] lastPathComponent];
        return url;
    }
    else if ([identify isEqualToString:@"filename"]) {
        NSString *url = [[infos objectAtIndex:row] lastPathComponent];
        return url;
    }
    else if ([identify isEqualToString:@"cal_title"]) {
        NSString *url = [[infos objectAtIndex:row] objectForKey:@"summary"];
        return url;
    }
    else if ([identify isEqualToString:@"cal_list"]) {
        NSString *url = [[infos objectAtIndex:row] objectForKey:@"title"];
        return url;
    }
    else if ([identify isEqualToString:@"cal_status"]) {
        NSString *url = [[infos objectAtIndex:row] objectForKey:@"completion_date"];
        NSNull *null = [NSNull null];
        if ((NSNull *)url != null) {
            return @"Completed";
        }
        return @"Uncompleted";
    }
    else if ([identify isEqualToString:@"msg_name"]) {
        NSArray *phones = [[infos objectAtIndex:row] objectForKey:@"msgphones"];
        for (int i=0; i<phones.count; i++) {
            NSString *callPhone = [phones objectAtIndex:i];
            NSString *sendName = [self getPhoneName:callPhone];
            if ([sendName isEqualToString:@"--"]) {
                continue;
            }
            else {
                return sendName;
            }
        }
        return @"--";
    }
    else if ([identify isEqualToString:@"msg_phone"]) {
        NSArray *phones = [[infos objectAtIndex:row] objectForKey:@"msgphones"];
        NSString *mobiles = @"";
        for (int i=0; i<phones.count; i++) {
            if (phones.count == i+1) {
                mobiles = [mobiles stringByAppendingFormat:@"%@", [phones objectAtIndex:i]];
            }
            else {
                mobiles = [mobiles stringByAppendingFormat:@"%@,", [phones objectAtIndex:i]];
            }
        }
        return mobiles;
    }
    return nil;
}

#pragma mark tableView delegate
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    id selectObj = [infos objectAtIndex:row];
    [[NSApp delegate] selectFileInfo:selectObj title:self.titleName];
    return YES;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [[NSApp delegate] judgeToolItemEnable];
}

@end
