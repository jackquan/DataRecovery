//
//  MyImageObject.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-3.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@interface MyImageObject : NSObject
{
    NSString *path;
}

-(void)setPath:(NSString*)newPath;
-(NSString*)path;

//
/////------------IKImageBrowserView item datasource protocol
-(NSString*)imageRepresentationType;
-(id)imageRepresentation;
-(NSString*)imageUID;

@end
