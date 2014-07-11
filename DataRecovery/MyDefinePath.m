//
//  MyDefinePath.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "MyDefinePath.h"
#import "DataHelper.h"
#import "Define.h"

@implementation MyDefinePath

+ (NSArray *)getBackupFiles
{
    NSString *backupPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/MobileSync/Backup/"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *backupContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:backupPath error:nil];
    NSMutableArray* fileInfoList = [NSMutableArray array];
    for (NSString *childName in backupContents) {
        if ([childName isEqualToString:@".DS_Store"]) {
            continue;
        }
        NSString *childPath = [backupPath stringByAppendingPathComponent:childName];
        
        NSString *plistFile = [childPath   stringByAppendingPathComponent:@"Info.plist"];
        
        NSError *error;
        NSDictionary *childInfo = [fm attributesOfItemAtPath:childPath error:&error];
        
        NSDate* modificationDate = [childInfo objectForKey:@"NSFileModificationDate"];
        
        NSDictionary* fileInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  childPath, @"fileName",
                                  modificationDate, @"modificationDate",
                                  plistFile, @"plistFile",
                                  nil];
        [fileInfoList addObject:fileInfo];
        
    }
    NSSortDescriptor* sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"modificationDate" ascending:NO] autorelease];
    [fileInfoList sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return fileInfoList;
}

+ (NSArray *)getPlistInfosOrBackupInfos:(NSArray *)infoList
{
    NSMutableArray *infosArray = [NSMutableArray array];
    for (NSDictionary *fileInfo in infoList) {
        NSString *plistFile = [fileInfo objectForKey:@"plistFile"];
        NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:plistFile];
        if (plistDic) {
            [infosArray addObject:plistDic];
        }
    }
    
    return infosArray;
}

+ (NSDictionary *)getSelectMbdbInfo:(NSDictionary *)device
{
    NSString* newestFolder = [device objectForKey:@"fileName"];
    NSDictionary *mbdb = [DataHelper getFileListForPath: newestFolder];
    return mbdb;
}

+ (void)setApplicationProductPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *productPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:PRODUCT_NAME];
    if ([[NSFileManager defaultManager] fileExistsAtPath:productPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:productPath error:nil];
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:productPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
}

+ (NSString *)getBackupPath:(NSString *)deviceName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *productPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:PRODUCT_NAME];
    NSString *devicePath = [productPath stringByAppendingPathComponent:deviceName];
    return devicePath;
}

+ (NSString *)writeData:(NSString *)childPath
               fileName:(NSString *)filename
                 fileId:(NSString *)fileid
             deviceName:(NSString *)deviceName
{
    NSString *dataPath = [childPath stringByAppendingPathComponent:fileid];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *productPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:PRODUCT_NAME];
    if (![[NSFileManager defaultManager] fileExistsAtPath:productPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:productPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    NSString *devicePath = [productPath stringByAppendingPathComponent:deviceName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:devicePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:devicePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    NSString *savePath = [devicePath stringByAppendingPathComponent:filename];
    if (data) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:savePath.stringByDeletingLastPathComponent]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:savePath.stringByDeletingLastPathComponent
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
        [data writeToFile:savePath atomically:YES];
    }
    else {
        [[NSFileManager defaultManager] createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return savePath;
}

+ (void)removeTemplateDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *productPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:PRODUCT_NAME];
    if ([[NSFileManager defaultManager] fileExistsAtPath:productPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:productPath error:nil];
    }
}

+ (NSString *)size_to_unit:(int)size
{
    NSString *okSize = nil;
    if (size<10*1024) {
        if (size>1000) {
            okSize = [NSString stringWithFormat:@"%.2f B", (float)size/1000];
        }
        else {
            okSize = [NSString stringWithFormat:@"%.2f", (float)size];
        }
    }
    else if (size<10*1024*1024) {
        if (size/1000>1000) {
            okSize = [NSString stringWithFormat:@"%.2f MB", (float)size/1000/1000];
        }
        else {
            okSize = [NSString stringWithFormat:@"%.2f KB", ((float)size/1000)];
        }
    }
    else if (size<10*1024*1024*1024) {
        if (size/1000/1000>1000) {
            okSize = [NSString stringWithFormat:@"%.2f GB", (float)size/1000/1000/1000];
        }
        else {
            okSize = [NSString stringWithFormat:@"%.2f MB", ((float)size/1000/1000)];
        }
    }
    else if (size<10*1024*1024*1024*1024) {
        if (size/1000/1000/1000>1000) {
            okSize = [NSString stringWithFormat:@"%.2f TB", (float)size/1000/1000/1000/1000];
        }
        else {
            okSize = [NSString stringWithFormat:@"%.2f GB", ((float)size/1000/1000/1000)];
        }
    }
    else {
        okSize = [NSString stringWithFormat:@"%.2f TB", ((float)size/1000/1000/1000/1000)];
    }
    
    return okSize;
}

+ (NSSize)getOKSize:(NSSize)size
{
    float w = size.width, h = size.height;
    int bei = w/100+1;
    float newH = h*bei;
    return NSMakeSize(100, newH);
}

@end
