//
//  Data.m
//  DataRecovery
//
//  Created by 全晖林 on 14-7-10.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

#import "Data.h"


#import "MyDefinePath.h"
#import "SQLiteDB.h"
#import "FilesInfoViewObj.h"
#import "FilesTypeObj.h"
#import "Define.h"
#import "SQLSelectLan.h"
#import "TableViewInfoSet.h"
#import "RecoveryFiles.h"

static NSArray *dataTypes = nil;
static NSArray *imageTypes = nil;
static NSArray *vedioTypes = nil;


@implementation Data

@synthesize photosData;
@synthesize deviceArray;
@synthesize backupPaths;

- (id)init
{
    if (self = [super init]) {
        self.backupPaths = [MyDefinePath getBackupFiles];
        self.deviceArray = [MyDefinePath getPlistInfosOrBackupInfos:backupPaths];
        //curDeviceName = nil;
        sortTypes = nil;
        //progressValue = 0, progressMaxValue = 0;
        dataTypes = [NSArray arrayWithObjects:ADDRESSBOOK, CALLHISTORY, NOTES,
                     SAFARI, CALENDAR, MESSAGE, PHOTOS, VIDIOS, nil];
        [dataTypes retain];
        imageTypes = [NSArray arrayWithObjects:@"png", @"jpeg", @"jpg", @"tiff", @"psd", nil];
        [imageTypes retain];
        vedioTypes = [NSArray arrayWithObjects:@"m4a", @"3gp", nil];
        [vedioTypes retain];
        
        [self  loadData];
    }
    return self;
}


-(void)loadData
{
    NSMutableArray *imagesPath=[[NSMutableArray alloc]init];
    
    NSMutableArray *vediosPath=[[NSMutableArray alloc]init];
    
    NSMutableArray *fileTypes=[[NSMutableArray alloc]init];
    
    NSString *childPath=@"/Users/mac1/Library/Application Support/MobileSync/Backup/09942524731cefc3da9d5a35749ba0a669786ab1";
    
    NSString *deviceName=@"“Administrator”的 iPad";

     NSDictionary *mbdb = [MyDefinePath getSelectMbdbInfo:[backupPaths objectAtIndex:0]];
    
    
    if (mbdb.count == 0) {
        if (NSRunAlertPanel(@"Warning", @"The Backup Files is not legal!", @"OK", nil, nil)) {
            return;
        }
    }

    
    
    for(NSNumber *offset in mbdb)
    {
        NSDictionary *fileInfo = [mbdb objectForKey:offset];
        if (fileInfo) {
            NSString *fileName = [fileInfo objectForKey:@"filename"];
            NSString *fileid = [fileInfo objectForKey:@"fileID"];
            //如果想将所有文件都写出来，则直接在这调用，删除后面的。
            //                NSString *savePath = [MyDefinePath writeData:childPath
            //                                                    fileName:fileName
            //                                                      fileId:fileid
            //                                                  deviceName:deviceName];
            
            if ([dataTypes containsObject:fileName.lastPathComponent]) {
                
                NSString *savePath = [MyDefinePath writeData:childPath
                                                    fileName:fileName
                                                      fileId:fileid
                                                  deviceName:deviceName];
                
                NSDictionary *dic = nil;
                if ([fileName.lastPathComponent isEqualToString:ADDRESSBOOK]) {
                    
                    NSArray *infos = [RecoveryFiles getAddressInfo:savePath];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           ADDRESSBOOKTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:CALLHISTORY]) {
                    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
                    NSArray *infos = [sDB getSQLItems:SQLCallHistoryLan];
                    [sDB release];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           CALLHISTORYTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:NOTES]) {
                    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
                    NSArray *infos = [sDB getSQLItems:SQLNotesLan];
                    [sDB release];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           NOTESTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:SAFARI]) {
                    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
                    NSArray *infos = [sDB getSafaris];
                    [sDB release];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           SAFARITITLE,  @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:CALENDAR]) {
                    SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
                    NSArray *infos = [sDB getSQLItems:SQLCalendarLan];
                    [sDB release];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           CALENDARTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:MESSAGE]) {
                    NSArray *infos = [RecoveryFiles getMsgInfo:savePath];
                    if (infos.count == 0) {
                        continue;
                    }
                    dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
                           MESSAGETITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
                }
                else if ([fileName.lastPathComponent isEqualToString:PHOTOS]) {
                    
                }
                else if ([fileName.lastPathComponent isEqualToString:VIDIOS]) {
                    
                }
                
                if (dic) {
                    [fileTypes addObject:dic];
                }
            }
            else if ([imageTypes containsObject:fileName.pathExtension.lowercaseString]) {
                NSString *savePath = [MyDefinePath writeData:childPath
                                                    fileName:fileName
                                                      fileId:fileid
                                                  deviceName:deviceName];
                [imagesPath addObject:savePath];
            }
            else if ([vedioTypes containsObject:fileName.pathExtension.lowercaseString]) {
                NSString *savePath = [MyDefinePath writeData:childPath
                                                    fileName:fileName
                                                      fileId:fileid
                                                  deviceName:deviceName];
                [vediosPath addObject:savePath];
            }
        }
    }
    
    
    
    if (vediosPath.count>0) {
        NSDictionary *vedioDic = [NSDictionary dictionaryWithObjectsAndKeys:VIDIOSTITLE, @"fileTitle", vediosPath, @"infos", [NSNumber numberWithInt:vediosPath.count], @"count", nil];
        [fileTypes addObject:vedioDic];
    }
    
    if (imagesPath.count>0) {
        
        photosData=imagesPath;
        NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:IMAGESTITLE, @"fileTitle", imagesPath, @"infos",  [NSNumber numberWithInt:imagesPath.count], @"count", nil];
        [fileTypes addObject:imageDic];
    }
    //    NSDictionary *backupDic = [NSDictionary dictionaryWithObject:BACKUPFILESTITLE forKey:@"fileTitle"];
    //    [fileTypes addObject:backupDic];
    
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"fileTitle" ascending:YES];
    sortTypes = [fileTypes sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDes]];
    [sortTypes retain];
    [fileTypes release];
    

  }

@end
