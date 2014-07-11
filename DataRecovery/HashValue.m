//
//  HashValue.m
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "HashValue.h"
#include "stdint.h"
#include <stdio.h>
#include <string.h>
#include "sha1.h"

@implementation HashValue

+ (NSString *)getHashValue:(NSString *)fullpath
{
    NSString *hashValue = @"";
    
    SHA1Context sha;
    int i, err;
    uint8_t Message_Digest[20];
    err = SHA1Reset(&sha);
    if (err) {
        return nil;
    }
    
    err = SHA1Input(&sha,
                    (const unsigned char *) fullpath.UTF8String,
                    strlen(fullpath.UTF8String));
    if (err)
    {
        fprintf(stderr, "SHA1Input Error %d.\n", err );
        return nil;
    }
    
    err = SHA1Result(&sha, Message_Digest);
    if (err)
    {
        return nil;
    }
    else
    {
        for(i = 0; i < 20 ; ++i)
        {
            hashValue = [hashValue stringByAppendingFormat:@"%02X", Message_Digest[i]];
        }
    }
    
    return hashValue;
}


@end
