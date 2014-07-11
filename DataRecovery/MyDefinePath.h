//
//  MyDefinePath.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDefinePath : NSObject

+ (NSArray *)getBackupFiles;
+ (NSArray *)getPlistInfosOrBackupInfos:(NSArray *)infoList;
+ (NSDictionary *)getSelectMbdbInfo:(NSDictionary *)device;

+ (void)setApplicationProductPath;
+ (NSString *)getBackupPath:(NSString *)deviceName;

+ (NSString *)writeData:(NSString *)childPath
               fileName:(NSString *)filename
                 fileId:(NSString *)fileid
             deviceName:(NSString *)deviceName;

+ (void)removeTemplateDirectory;

+ (NSString *)size_to_unit:(int)size;

+ (NSSize)getOKSize:(NSSize)size;

@end
