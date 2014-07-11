//
//  RecoveryFiles.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//


#import "RecoveryFiles.h"
#import "Define.h"
#import "AppDelegate.h"
#import "FilesInfoViewObj.h"
#import "SQLiteDB.h"
#import "SQLSelectLan.h"

@implementation RecoveryFiles

+ (void)recoveryChooseFiles:(NSString *)title infos:(NSArray *)infos
{
    NSTableView *infoTableView = [[NSApp delegate] tableView_info];
    NSIndexSet *indexSet = [infoTableView selectedRowIndexes];
    NSArray *selectItems = [infos objectsAtIndexes:indexSet];
    
    if ([title isEqualToString:IMAGESTITLE] || [title isEqualToString:VIDIOSTITLE]) {
        [self saveImagesOrVedioData:selectItems];
    }
    else if ([title isEqualToString:BACKUPFILESTITLE]) {
        
    }
    else if ([title isEqualToString:SAFARITITLE]) {
        
        [self saveSafariData:selectItems];
    }
    else if ([title isEqualToString:ADDRESSBOOKTITLE]) {
        [self saveAddressBookData:selectItems];
    }
    else if ([title isEqualToString:CALLHISTORYTITLE]) {
        
    }
    else if ([title isEqualToString:NOTESTITLE]){
        
    }
    else if ([title isEqualToString:MESSAGETITLE]){
        
    }
}

#pragma mark save data
+ (void)saveImagesOrVedioData:(NSArray *)items
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSWindow *mainWindow = [[NSApp delegate] window];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setExtensionHidden:NO];
    [savePanel setCanCreateDirectories:YES];
    [savePanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            [savePanel orderOut:nil];
            
            NSString *path = savePanel.URL.path;
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            for (int i=0; i<items.count; i++) {
                NSString *imagePath = [items objectAtIndex:i];
                [fileManager copyItemAtPath:imagePath
                                     toPath:[path stringByAppendingPathComponent:imagePath.lastPathComponent]
                                      error:nil];
            }
        }
    }];
}

+ (void)saveSafariData:(NSArray *)items
{
    NSWindow *mainWindow = [[NSApp delegate] window];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setExtensionHidden:NO];
    [savePanel setCanCreateDirectories:YES];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"html", nil]];
    [savePanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            [savePanel orderOut:nil];
            
            NSString *path = savePanel.URL.path;
            NSData *xmlData = [self writeHtmlData:items];
            [xmlData writeToFile:path atomically:YES];
        }
    }];
}

+ (void)saveAddressBookData:(NSArray *)items
{
    NSWindow *mainWindow = [[NSApp delegate] window];
    
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setExtensionHidden:NO];
    [savePanel setCanCreateDirectories:YES];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObjects:@"txt", nil]];
    [savePanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result) {
        if (result == NSOKButton) {
            
            [savePanel orderOut:nil];
            
            NSURL *saveURL = [savePanel URL];
            NSMutableString *dataString = [[NSMutableString alloc] init];
            for (int i=0; i<items.count; i++) {
                NSDictionary *dic = [items objectAtIndex:i];
                NSArray *allKeys = [dic allKeys];
                NSString *strValue = @"";
                for (NSString *str in allKeys) {
                    if ([str isEqualToString:@"company"] ||
                        [str isEqualToString:@"infos"]) {
                        continue;
                    }
                    NSString *value = [dic objectForKey:str];
                    strValue = [strValue stringByAppendingFormat:@"%@  ", value];
                }
                strValue = [strValue stringByAppendingFormat:@"\n"];
                [dataString appendString:strValue];
            }
            [dataString writeToURL:saveURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
            [dataString release];
        }
    }];
}

#pragma mark html data save
+ (NSData *)writeHtmlData:(NSArray *)items
{
    NSXMLElement *rootElement = [[NSXMLElement alloc] initWithName:@"HTML"];
    NSXMLDocument *xmlDoc = [[[NSXMLDocument alloc] initWithRootElement:rootElement] autorelease];
    [xmlDoc setCharacterEncoding:@"UTF-8"];
    [xmlDoc setVersion:@"1.0"];
    
    NSXMLElement *titleNode = [[NSXMLElement alloc] initWithName:@"TITLE"];
    [titleNode setStringValue:@"Safari Bookmarks"];
    [rootElement addChild:titleNode];
    [titleNode release];
    
    for (int i=0; i<items.count; i++) {
        NSString *title = [[items objectAtIndex:i] objectForKey:@"title"];
        NSString *url = [[items objectAtIndex:i] objectForKey:@"url"];
        
        NSXMLElement *divNode = [[NSXMLElement alloc] initWithName:@"DIV"];
        NSXMLElement *linkNode = [[NSXMLElement alloc] initWithName:@"A"];
        [linkNode addAttribute:[NSXMLNode attributeWithName:@"HREF" stringValue:url]];
        [linkNode setStringValue:title];
        [divNode addChild:linkNode];
        [linkNode release];
        [rootElement addChild:divNode];
        [divNode release];
        
        NSXMLElement *br = [[NSXMLElement alloc] initWithName:@"br"];
        [rootElement addChild:br];
        [br release];
    }
    
    [rootElement release];
    
    NSData *xmlData = [xmlDoc XMLDataWithOptions:NSXMLNodePrettyPrint];
    return xmlData;
}















#pragma mark get address info
+ (NSString *)getAddressName:(NSString *)firstName lastName:(NSString *)lastName
{
    NSString *mergeName = nil;
    if ((NSNull *)firstName == [NSNull null] && (NSNull *)lastName == [NSNull null]) {
        mergeName = @"--";
    }
    else if ((NSNull *)firstName == [NSNull null] && (NSNull *)lastName != [NSNull null]) {
        mergeName = lastName;
    }
    else if ((NSNull *)firstName != [NSNull null] && (NSNull *)lastName == [NSNull null]) {
        mergeName = firstName;
    }
    else {
        mergeName = [firstName stringByAppendingFormat:@"  %@", lastName];
    }
    return mergeName;
}

+ (NSString *)modifyValue:(NSString *)value
{//_$!<WorkFAX>!$_
    
    int a=0, b=0;
    for (int i=0; i<value.length; i++) {
        unichar ch = [value characterAtIndex:i];
        if (ch == '<') {
            a=i;
        }
        
        if (ch == '>') {
            b=i;
        }
    }
    
    if (a==0 && b==0) {
        return [NSString stringWithFormat:@"%@:", value];
    }
    
    NSString *strValue = [NSString stringWithFormat:@"%@:", [value substringWithRange:NSMakeRange(a+1, b-a-1)]];
    
    return strValue;
}

+ (NSArray *)getAddressInfo:(NSString *)savePath
{
    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
    NSArray *allPersons = [sDB getSQLItems:SQLAddressBookLan];
    NSArray *allValues = [sDB getSQLItems:SQLAddressValueLan];
    NSArray *allLabels = [sDB getSQLItems:SQLAddressLabelLan];
    NSArray *allEntrys = [sDB getSQLItems:SQLAddressEntryLan];
    [sDB release];
    
    NSMutableArray *okArray = [NSMutableArray array];
    
    for (NSDictionary *personDic in allPersons)
    {
        int rowID = [[personDic objectForKey:@"ROWID"] intValue];
        NSString *first = [personDic objectForKey:@"First"];
        NSString *last = [personDic objectForKey:@"Last"];
        NSString *mergeName = [self getAddressName:first lastName:last];
        NSString *company = [personDic objectForKey:@"Organization"];
        
        NSMutableArray *allDics = [[NSMutableArray alloc] init];//重设value的信息
        for (NSDictionary *valueDic in allValues)
        {
            NSString *idStr = [valueDic objectForKey:@"record_id"];
            int recordID = [idStr intValue];
            int value_labelID = [[valueDic objectForKey:@"label"] intValue];
            NSString *value = [valueDic objectForKey:@"value"];
            
            if (recordID == rowID) {
                
                for (NSDictionary *labelDic in allLabels)
                {
                    int labelID = [[labelDic objectForKey:@"rowid"] intValue];
                    NSString *labelValue = [labelDic objectForKey:@"value"];
                    
                    if (labelID == value_labelID) {
                        
                        NSString *workString = @"";
                        if (allEntrys.count>0) {
                            for (NSDictionary *entryDic in allEntrys) {
                                int entryID = [[entryDic objectForKey:@"parent_id"] intValue];
                                NSString *entryValue = [entryDic objectForKey:@"value"];
                                if (labelID == entryID) {
                                    workString = [workString stringByAppendingFormat:@"%@ ", entryValue];
                                }
                            }
                        }
                        
                        if (![workString isEqualToString:@""]) {
                            value = workString;
                        }
                        
                        NSDictionary *dicValue = [NSDictionary dictionaryWithObjectsAndKeys:idStr, @"id", labelValue, @"labelValue", value, @"value", nil];
                        [allDics addObject:dicValue];
                    }
                }
                
            }
        }
        
        NSDictionary *lastDic = nil;
        
        NSString *phone = nil;
        
        NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
        for (int i=0; i<allDics.count; i++) {
            NSDictionary *dicInfo = [allDics objectAtIndex:i];
            
            int okID = [[dicInfo objectForKey:@"id"] intValue];
            NSString *value = [dicInfo objectForKey:@"value"];
            NSString *labelValue = [dicInfo objectForKey:@"labelValue"];
            
            if (rowID == okID) {
                labelValue = [self modifyValue:labelValue];
                [infoDic setObject:value forKey:labelValue];
                
                if ([labelValue isEqualToString:@"Mobile:"]) {
                    if (phone == nil) {
                        phone = value;
                    }
                }
                else if ([labelValue isEqualToString:@"Main:"]) {
                    if (phone == nil) {
                        phone = value;
                    }
                }
                else if ([labelValue isEqualToString:@"WorkFAX:"]) {
                    if (phone == nil) {
                        phone = value;
                    }
                }
            }
        }
        
        lastDic = [NSDictionary dictionaryWithObjectsAndKeys:mergeName, @"fname",
                   phone, @"number",
                   company, @"company",
                   infoDic, @"infos", nil];
        
        [infoDic release];
        
        [okArray addObject:lastDic];
        
        [allDics release];
        
    }
    
    return okArray;
}

#pragma mark get msg info
+ (NSArray *)getMsgInfo:(NSString *)savePath
{
    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
    NSArray *allMsgGroups = [sDB getSQLItems:SQLMsg_Group];
    NSArray *allMembers = [sDB getSQLItems:SQLMsg_Member];
    NSArray *allMessages = [sDB getSQLItems:SQLMsg_Message];
    [sDB release];
    
    NSMutableArray *msgInfos = [NSMutableArray array];
    
    for (NSDictionary *msgGroupDic in allMsgGroups)
    {
        int rowID = [[msgGroupDic objectForKey:@"ROWID"] intValue];
        
        NSMutableArray *phoneArr = [[NSMutableArray alloc] init];//号码
        for (NSDictionary *msgMemberDic in allMembers) {
            int memID = [[msgMemberDic objectForKey:@"group_id"] intValue];
            NSString *address = [msgMemberDic objectForKey:@"address"];
            
            if (memID == rowID) {
                [phoneArr addObject:address];
            }
        }
        
        NSMutableArray *msgArr = [[NSMutableArray alloc] init];//信息
        for (NSDictionary *msgMessageDic in allMessages) {
            int msgID = [[msgMessageDic objectForKey:@"group_id"] intValue];
            NSString *date = [msgMessageDic objectForKey:@"date"];
            NSString *text = [msgMessageDic objectForKey:@"text"];
            NSString *flags = [msgMessageDic objectForKey:@"flags"];
            
            if (msgID == rowID) {
                [msgArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:date, @"date",
                                   text, @"text", flags, @"flag", nil]];
            }
        }
        
        [msgInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:phoneArr, @"msgphones",
                             msgArr,@"msginfos", nil]];
        
        [msgArr release];
        [phoneArr release];
    }
    
    
    return msgInfos;
}


@end
