//
//  FilesTypeObj.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesDataRecoveryViewController.h"

@interface FilesTypeObj : NSObject
{
    iTunesDataRecoveryViewController *itunesDataRecoveryViewController;
    NSArray *types;
}

@property(readwrite,retain)NSArray *types;
@property (assign)iTunesDataRecoveryViewController *itunesDataRecoveryViewController;

@end
