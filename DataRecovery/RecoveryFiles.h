//
//  RecoveryFiles.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecoveryFiles : NSObject

+ (void)recoveryChooseFiles:(NSString *)title infos:(NSArray *)infos;


#pragma mark save data
+ (void)saveImagesOrVedioData:(NSArray *)items;
+ (void)saveSafariData:(NSArray *)items;
+ (void)saveAddressBookData:(NSArray *)items;

#pragma mark html data save
+ (NSData *)writeHtmlData:(NSArray *)items;

#pragma mark get address info
+ (NSArray *)getAddressInfo:(NSString *)savePath;
+ (NSString *)getAddressName:(NSString *)firstName lastName:(NSString *)lastName;
+ (NSString *)modifyValue:(NSString *)value;

#pragma mark get msg info
+ (NSArray *)getMsgInfo:(NSString *)savePath;

@end
