//
//  MyImageObject.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-7-3.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "MyImageObject.h"

@implementation MyImageObject

-(void)dealloc
{
    [super dealloc];
}


-(void)setPath:(NSString *)newPath
{
    if(path!=newPath)
    {
        [path release];
        path=[newPath retain];
    }
}

-(NSString*)path
{
    return path;
}


/* required methods of the IKImageBrowserItem protocol */
#pragma mark item data source protocol


/* let the image browser knows we use a path representation */
-(NSString*)imageRepresentationType
{
    return IKImageBrowserQuickLookPathRepresentationType;
}

/* give our representation to the image browser */
-(id)imageRepresentation
{
    return path;
}

/* use the absolute filepath as identifier */
-(NSString*)imageUID
{
    return path;
}
-(NSString*)imageTitle
{
    return [path lastPathComponent];
    //return [[path lastPathComponent] stringByDeletingLastPathComponent];
}
- (NSString *) imageSubtitle
{
    return path;
}

@end



