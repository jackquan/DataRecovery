//
//  FilesInfoViewObj.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FilesInfoViewObj : NSObject
{
    NSArray *infos;
    NSArray *names;
    
    NSString *titleName;
}

@property (readwrite, retain) NSArray *infos;
@property (readwrite, retain) NSArray *names;

@property (readwrite, retain) NSString *titleName;

- (NSString *)getPhoneName:(NSString *)number;


@end


