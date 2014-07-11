////
////  iTunesAppDelegate.m
////  DataRecoveryUI
////
////  Created by 全晖林 on 14-6-30.
////  Copyright (c) 2014年 全晖林. All rights reserved.
////
//
//#import "iTunesAppDelegate.h"
//#import "MyDefinePath.h"
//#import "SQLiteDB.h"
//#import "FilesInfoViewObj.h"
//#import "FilesTypeObj.h"
//#import "Define.h"
//#import "SQLSelectLan.h"
//#import "TableViewInfoSet.h"
//#import "RecoveryFiles.h"
//
//
//static NSArray *dataTypes = nil;
//static NSArray *imageTypes = nil;
//static NSArray *vedioTypes = nil;
//
//@implementation iTunesAppDelegate
//
//@synthesize tableView_info, window;
//
//@synthesize progressValue, progressMaxValue;
//@synthesize deviceArray;
//@synthesize backupPaths;
//
//@synthesize curDeviceName;
//
//- (id)init
//{
//    if (self = [super init]) {
//        self.backupPaths = [MyDefinePath getBackupFiles];
//        self.deviceArray = [MyDefinePath getPlistInfosOrBackupInfos:backupPaths];
//        curDeviceName = nil;
//        sortTypes = nil;
//        progressValue = 0, progressMaxValue = 0;
//        dataTypes = [NSArray arrayWithObjects:ADDRESSBOOK, CALLHISTORY, NOTES,
//                     SAFARI, CALENDAR, MESSAGE, PHOTOS, VIDIOS, nil];
//        [dataTypes retain];
//        imageTypes = [NSArray arrayWithObjects:@"png", @"jpeg", @"jpg", @"tiff", @"psd", nil];
//        [imageTypes retain];
//        vedioTypes = [NSArray arrayWithObjects:@"m4a", @"3gp", nil];
//        [vedioTypes retain];
//    }
//    return self;
//}
//
//- (void)awakeFromNib
//{
//    filesTypeObj = [[FilesTypeObj alloc] init];
//    
//    [tableView_title setDataSource:(id<NSTableViewDataSource>)filesTypeObj];
//    [tableView_title setDelegate:(id<NSTableViewDelegate>)filesTypeObj];
//    
//    [mySplitView setDelegate:(id<NSSplitViewDelegate>)self];
//    
//    [MyDefinePath setApplicationProductPath];
//    
//    [recoveryItem setEnabled:NO];
//}
//
//- (void)dealloc
//{
//    [filesTypeObj release];
//    
//    [deviceArray release];
//    [backupPaths release];
//    [curDeviceName release];
//    [sortTypes release];
//    
//    [dataTypes release], [imageTypes release], [vedioTypes release];
//    [super dealloc];
//}
//
//- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
//{
//    return YES;
//}
//
//- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
//{
//    
//}
//
//#pragma mark splitView delegate
//
//- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex
//{
//    if (dividerIndex == 0) {
//        return 180.0;
//    }
//    return 602.0;
//}
//
//- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex
//{
//    if (dividerIndex == 0) {
//        return 180.0;
//    }
//    return 802.0;
//}
//
//#pragma mark window close delegate
//- (BOOL)windowShouldClose:(id)sender
//{
//    [MyDefinePath removeTemplateDirectory];
//    return YES;
//}
//
//#pragma mark data methods
//- (void)addInfoView
//{
//    [window setToolbar:myToolbar];
//    NSView *mainView = [window contentView];
//    [infoView setFrame:mainView.frame];
//    [mainView addSubview:infoView];
//    [mySplitView setPosition:180.0 ofDividerAtIndex:0];
//}
//
//- (void)startProgressWindow
//{
//    [NSApp beginSheet:progressWindow
//       modalForWindow:window
//        modalDelegate:nil
//       didEndSelector:nil
//          contextInfo:nil];
//    [progressWindow makeKeyAndOrderFront:self];
//}
//
//- (void)stopProgressWindow
//{
//    [NSApp endSheet:progressWindow];
//    [progressWindow orderOut:self];
//}
//
//- (void)loadData
//{
//    
//    NSMutableArray *imagesPath = [[NSMutableArray alloc] init];
//    NSMutableArray *vediosPath = [[NSMutableArray alloc] init];
//    NSMutableArray *fileTypes = [[NSMutableArray alloc] init];
//    
//    if (tableView_device.selectedRowIndexes.count > 0) {
//        
//        NSString *childPath = [[backupPaths objectAtIndex:tableView_device.selectedRow] objectForKey:@"fileName"];
//        NSString *deviceName = [[deviceArray objectAtIndex:tableView_device.selectedRow] objectForKey:@"Device Name"];
//        self.curDeviceName = deviceName;
//        NSDictionary *mbdb = [MyDefinePath getSelectMbdbInfo:[backupPaths objectAtIndex:tableView_device.selectedRow]];
//        
//        if (mbdb.count == 0) {
//            if (NSRunAlertPanel(@"Warning", @"The Backup Files is not legal!", @"OK", nil, nil)) {
//                return;
//            }
//        }
//        
//        [self startProgressWindow];
//        
//        self.progressMaxValue = mbdb.count;
//        for(NSNumber *offset in mbdb)
//        {
//            self.progressValue++;
//            NSDictionary *fileInfo = [mbdb objectForKey:offset];
//            if (fileInfo) {
//                NSString *fileName = [fileInfo objectForKey:@"filename"];
//                NSString *fileid = [fileInfo objectForKey:@"fileID"];
//                //如果想将所有文件都写出来，则直接在这调用，删除后面的。
//                //                NSString *savePath = [MyDefinePath writeData:childPath
//                //                                                    fileName:fileName
//                //                                                      fileId:fileid
//                //                                                  deviceName:deviceName];
//                
//                if ([dataTypes containsObject:fileName.lastPathComponent]) {
//                    
//                    NSString *savePath = [MyDefinePath writeData:childPath
//                                                        fileName:fileName
//                                                          fileId:fileid
//                                                      deviceName:deviceName];
//                    
//                    NSDictionary *dic = nil;
//                    if ([fileName.lastPathComponent isEqualToString:ADDRESSBOOK]) {
//                        
//                        NSArray *infos = [RecoveryFiles getAddressInfo:savePath];
//                        [filesInfoObj setNames:infos];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               ADDRESSBOOKTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:CALLHISTORY]) {
//                        SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
//                        NSArray *infos = [sDB getSQLItems:SQLCallHistoryLan];
//                        [sDB release];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               CALLHISTORYTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:NOTES]) {
//                        SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
//                        NSArray *infos = [sDB getSQLItems:SQLNotesLan];
//                        [sDB release];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               NOTESTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:SAFARI]) {
//                        SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
//                        NSArray *infos = [sDB getSafaris];
//                        [sDB release];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               SAFARITITLE,  @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:CALENDAR]) {
//                        SQLiteDB *sDB = [[SQLiteDB alloc] initWithDBFilename:savePath];
//                        NSArray *infos = [sDB getSQLItems:SQLCalendarLan];
//                        [sDB release];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               CALENDARTITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:MESSAGE]) {
//                        NSArray *infos = [RecoveryFiles getMsgInfo:savePath];
//                        if (infos.count == 0) {
//                            continue;
//                        }
//                        dic = [NSDictionary dictionaryWithObjectsAndKeys:savePath, @"savePath", infos, @"infos",
//                               MESSAGETITLE, @"fileTitle", [NSNumber numberWithInt:infos.count], @"count", nil];
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:PHOTOS]) {
//                        
//                    }
//                    else if ([fileName.lastPathComponent isEqualToString:VIDIOS]) {
//                        
//                    }
//                    
//                    if (dic) {
//                        [fileTypes addObject:dic];
//                    }
//                }
//                else if ([imageTypes containsObject:fileName.pathExtension.lowercaseString]) {
//                    NSString *savePath = [MyDefinePath writeData:childPath
//                                                        fileName:fileName
//                                                          fileId:fileid
//                                                      deviceName:deviceName];
//                    [imagesPath addObject:savePath];
//                }
//                else if ([vedioTypes containsObject:fileName.pathExtension.lowercaseString]) {
//                    NSString *savePath = [MyDefinePath writeData:childPath
//                                                        fileName:fileName
//                                                          fileId:fileid
//                                                      deviceName:deviceName];
//                    [vediosPath addObject:savePath];
//                }
//            }
//        }
//    }
//    
//    if (vediosPath.count>0) {
//        NSDictionary *vedioDic = [NSDictionary dictionaryWithObjectsAndKeys:VIDIOSTITLE, @"fileTitle", vediosPath, @"infos", [NSNumber numberWithInt:vediosPath.count], @"count", nil];
//        [fileTypes addObject:vedioDic];
//    }
//    
//    if (imagesPath.count>0) {
//        NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:IMAGESTITLE, @"fileTitle", imagesPath, @"infos",  [NSNumber numberWithInt:imagesPath.count], @"count", nil];
//        [fileTypes addObject:imageDic];
//    }
//    //    NSDictionary *backupDic = [NSDictionary dictionaryWithObject:BACKUPFILESTITLE forKey:@"fileTitle"];
//    //    [fileTypes addObject:backupDic];
//    
//    [imagesPath release], [vediosPath release];
//    
//    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"fileTitle" ascending:YES];
//    sortTypes = [fileTypes sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDes]];
//    [sortTypes retain];
//    [filesTypeObj setTypes:sortTypes];
//    [fileTypes release];
//    
//    [tableView_title reloadData];
//    
//    if (sortTypes.count>0) {
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//        [tableView_title selectRowIndexes:indexSet byExtendingSelection:NO];
//        [tableView_title scrollRowToVisible:0];
//        [self selectFileTypePath:[[sortTypes objectAtIndex:0] objectForKey:@"fileTitle"]
//                   mediasOrInfos:[[sortTypes objectAtIndex:0] objectForKey:@"infos"]];
//    }
//    
//    [self stopProgressWindow];
//    [self addInfoView];
//}
//
//#pragma mark tableView dataSource
//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
//{
//    return deviceArray.count;
//}
//
//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    NSString *identify = [tableColumn identifier];
//    if ([identify isEqualToString:@"name"]) {
//        return [[deviceArray objectAtIndex:row] objectForKey:@"Device Name"];
//    }
//    else if ([identify isEqualToString:@"date"]) {
//        return [[deviceArray objectAtIndex:row] objectForKey:@"Last Backup Date"];
//    }
//    else {
//        return [[deviceArray objectAtIndex:row] objectForKey:@"Serial Number"];
//    }
//    return nil;
//}
//
//#pragma mark action button
//- (IBAction)startScanAction:(id)sender
//{
//    NSInteger selectedRow = [tableView_device selectedRow];
//    if (selectedRow < 0) {
//        return;
//    }
//    [NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
//}
//
//- (IBAction)barBackAction:(id)sender
//{
//    self.progressValue = 0.0;
//    self.progressMaxValue = 0.0;
//    [window setToolbar:nil];
//    [infoView removeFromSuperview];
//}
//
//- (IBAction)barRecoveryAction:(id)sender
//{
//    NSDictionary *dic = [sortTypes objectAtIndex:tableView_title.selectedRow];
//    NSString *title = [dic objectForKey:@"fileTitle"];
//    NSArray *infos = [dic objectForKey:@"infos"];
//    [RecoveryFiles recoveryChooseFiles:title infos:infos];
//}
//
//- (IBAction)printAction:(id)sender
//{
//    NSView *printView = (NSView *)tableView_info;
//    
//    NSPrintInfo *sharedInfo = [NSPrintInfo sharedPrintInfo];
//    NSMutableDictionary *printInfoDict = [sharedInfo dictionary];
//    
//    
//    NSSavePanel *savePanel = [NSSavePanel savePanel];
//    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"pdf"]];
//    [savePanel setCanCreateDirectories:YES];
//    [savePanel setExtensionHidden:NO];
//    [savePanel beginSheetModalForWindow:window completionHandler:^(NSInteger result) {
//        if (result == NSOKButton) {
//            [savePanel orderOut:sender];
//            
//            [printInfoDict setObject:NSPrintSaveJob
//                              forKey:NSPrintJobDisposition];
//            NSString *path = savePanel.URL.path;
//            [printInfoDict setObject:path forKey:NSPrintSavePath];
//            
//            NSPrintInfo *printInfo = [[NSPrintInfo alloc] initWithDictionary: printInfoDict];
//            [printInfo setHorizontalPagination: NSAutoPagination];
//            [printInfo setVerticalPagination: NSAutoPagination];
//            [printInfo setHorizontallyCentered:NO];
//            [printInfo setVerticallyCentered:NO];
//            
//            [printInfo setTopMargin:50];
//            [printInfo setBottomMargin:50];
//            [printInfo setLeftMargin:2];
//            [printInfo setRightMargin:2];
//            [printInfo setPaperSize:NSMakeSize(printView.frame.size.width+5, 802.0)];
//            
//            NSPrintOperation *op = [NSPrintOperation printOperationWithView:printView
//                                                                  printInfo:printInfo];
//            
//            [op setShowsPrintPanel:NO];
//            [op	setShowsProgressPanel:YES];
//            
//            [op runOperation];
//            [printInfo release];
//        }
//    }];
//}
//
//
//#pragma mark select type path
//- (void)clearScrollView_chView_chView
//{
//    NSArray *views = [scrollView_chView subviews];
//    for (int i=0; i<views.count; i++) {
//        NSView *view = [views objectAtIndex:i];
//        [view removeFromSuperview];
//    }
//}
//
//- (void)selectFileTypePath:(NSString *)titleName mediasOrInfos:(NSArray *)medias
//{
//    [self clearScrollView_chView_chView];
//    
//    NSArray *columns = [tableView_info tableColumns];
//    int count = columns.count;
//    for (int i=0; i<count; i++) {
//        [tableView_info removeTableColumn:[columns objectAtIndex:0]];
//    }
//    
//    NSArray *infos = medias;
//    
//    if ([titleName isEqualToString:ADDRESSBOOKTITLE]) {
//        [TableViewInfoSet addressBookTableViewSet:tableView_info];
//        [mySplitView setPosition:602.0 ofDividerAtIndex:1];
//        [scrollView_chView addSubview:addressInfoView];
//    }
//    else if ([titleName isEqualToString:SAFARITITLE]) {
//        [TableViewInfoSet safariTableViewSet:tableView_info];
//        [mySplitView setPosition:802.0 ofDividerAtIndex:1];
//    }
//    else if ([titleName isEqualToString:NOTESTITLE]) {
//        [TableViewInfoSet noteTableViewSet:tableView_info];
//        [mySplitView setPosition:802.0 ofDividerAtIndex:1];
//    }
//    else if ([titleName isEqualToString:CALENDARTITLE]) {
//        [TableViewInfoSet calendarTableViewSet:tableView_info];
//        [scrollView_chView addSubview:calendarInfoView];
//        [mySplitView setPosition:602.0 ofDividerAtIndex:1];
//    }
//    else if ([titleName isEqualToString:MESSAGETITLE]) {
//        [TableViewInfoSet messageTableViewSet:tableView_info];
//        [mySplitView setPosition:602.0 ofDividerAtIndex:1];
//        [scrollView_chView addSubview:messageView];
//    }
//    else if ([titleName isEqualToString:CALLHISTORYTITLE]) {
//        [TableViewInfoSet callHistoryTableViewSet:tableView_info];
//        [mySplitView setPosition:802.0 ofDividerAtIndex:1];
//    }
//    else if ([titleName isEqualToString:IMAGESTITLE]) {
//        [TableViewInfoSet imageTableViewSet:tableView_info];
//        [mySplitView setPosition:602.0 ofDividerAtIndex:1];
//        [scrollView_chView addSubview:mediaInfoView];
//    }
//    else if ([titleName isEqualToString:VIDIOSTITLE]) {
//        [TableViewInfoSet vedioTableViewSet:tableView_info];
//        [mySplitView setPosition:602.0 ofDividerAtIndex:1];
//        [scrollView_chView addSubview:mediaInfoView];
//    }
//    else if ([titleName isEqualToString:BACKUPFILESTITLE]) {
//        NSString *backupPath = [MyDefinePath getBackupPath:self.curDeviceName];
//        NSArray *names = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:backupPath error:nil];
//        infos = names;
//        [TableViewInfoSet backupFilesLoad:tableView_info];
//        [mySplitView setPosition:802.0 ofDividerAtIndex:1];
//    }
//    
//    [filesInfoObj setInfos:infos];
//    [filesInfoObj setTitleName:titleName];
//    [tableView_info reloadData];
//    if (infos.count>0) {
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//        [tableView_info selectRowIndexes:indexSet byExtendingSelection:NO];
//        [tableView_info scrollRowToVisible:0];
//        [self selectFileInfo:[infos objectAtIndex:0] title:titleName];
//    }
//}
//
//#pragma mark select info path
//- (void)judgeToolItemEnable
//{
//    if (tableView_info.numberOfSelectedRows>0) {
//        [recoveryItem setEnabled:YES];
//    }
//    else {
//        [recoveryItem setEnabled:NO];
//    }
//    
//    if (tableView_title.numberOfSelectedRows>0) {
//        NSString *title = [[[(FilesTypeObj *)tableView_title.dataSource types]
//                            objectAtIndex:tableView_title.selectedRow]
//                           objectForKey:@"fileTitle"];
//        if ([title isEqualToString:IMAGESTITLE] ||
//            [title isEqualToString:VIDIOSTITLE] ||
//            [title isEqualToString:BACKUPFILESTITLE]) {
//            [savePDFItem setEnabled:NO];
//        }
//        else {
//            [savePDFItem setEnabled:YES];
//        }
//    }
//}
//
//- (void)selectFileInfo:(id)info title:(NSString *)titleName
//{
//    if ([titleName isEqualToString:IMAGESTITLE] ||
//        [titleName isEqualToString:VIDIOSTITLE]) {
//        NSString *path = info;
//        if ([imageTypes containsObject:path.pathExtension.lowercaseString]) {
//            NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
//            [myImageView setImage:image];
//            [image release];
//            
//            NSDictionary *fileinfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//            NSString *size = [fileinfo objectForKey:NSFileSize];
//            [size_label setStringValue:[MyDefinePath size_to_unit:size.intValue]];
//            [name_label setStringValue:path.lastPathComponent];
//        }
//        else if ([vedioTypes containsObject:path.pathExtension.lowercaseString]) {
//            NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initWithPath:path];
//            NSImage *icon = [fileWrapper icon];
//            [icon setSize:NSMakeSize(500, 500)];
//            [myImageView setImage:icon];
//            NSDictionary *fileinfo = [fileWrapper fileAttributes];
//            NSString *size = [fileinfo objectForKey:NSFileSize];
//            [name_label setStringValue:path.lastPathComponent];
//            [size_label setStringValue:[MyDefinePath size_to_unit:size.intValue]];
//            [fileWrapper release];
//        }
//    }
//    else if ([titleName isEqualToString:CALENDARTITLE]) {
//        NSDictionary *dic = info;
//        [title_label setStringValue:[dic objectForKey:@"summary"]];
//        [descrip_label setStringValue:[dic objectForKey:@"description"]];
//    }
//    else if ([titleName isEqualToString:ADDRESSBOOKTITLE]) {
//        NSDictionary *dic = info;
//        NSString *mergeName = [dic objectForKey:@"fname"];
//        NSArray *views = [addressInfoView subviews];
//        for (int i=0; i<views.count; i++) {
//            NSView *view = [views objectAtIndex:i];
//            if ([view isKindOfClass:[NSTextField class]]) {
//                [view removeFromSuperview];
//                i--;
//            }
//        }
//        
//        NSTextField *addressName_label = [[NSTextField alloc] init];
//        [addressName_label setFrame:NSMakeRect(68.0, 498.0, 119.0, 17.0)];
//        [addressName_label setBordered:NO];
//        [addressName_label setEditable:NO];
//        [addressName_label setFont:[NSFont fontWithName:@"Lucida Grande" size:13.0]];
//        [addressName_label setStringValue:mergeName];
//        [addressInfoView addSubview:addressName_label];
//        
//        [self addLabelToAddressView:[dic objectForKey:@"infos"]];
//    }
//    else if ([titleName isEqualToString:MESSAGETITLE]) {
//        NSArray *msgInfos = [info objectForKey:@"msginfos"];
//        
//        NSArray *views = [messageView subviews];
//        for (int i=0; i<views.count; i++) {
//            NSView *view = [views objectAtIndex:i];
//            if ([view isKindOfClass:[NSBox class]]) {
//                [view removeFromSuperview];
//                i--;
//            }
//        }
//        
//        [self addBoxToMsgView:msgInfos];
//    }
//}
//
//- (void)addBoxToMsgView:(NSArray *)msgInfos
//{
//    if (msgInfos.count>0) {
//        
//        CGFloat x=4.0, y=370.0;
//        
//        for (int i=0; i<msgInfos.count; i++) {
//            
//            NSString *flag = [[msgInfos objectAtIndex:i] objectForKey:@"flag"];
//            
//            NSString *sendOrReceive = nil;
//            if (flag.intValue == 2) {//发送
//                sendOrReceive = @"Send";
//            }
//            else if (flag.intValue == 3) {//接收
//                sendOrReceive = @"Receive";
//            }
//            else {
//                continue;
//            }
//            
//            NSString *date = [[msgInfos objectAtIndex:i] objectForKey:@"date"];
//            
//            if (i>0) {
//                NSString *lastDate = [[msgInfos objectAtIndex:i-1] objectForKey:@"date"];
//                if (date.intValue == lastDate.intValue) {
//                    continue;
//                }
//            }
//            
//            NSString *text = [[msgInfos objectAtIndex:i] objectForKey:@"text"];
//            
//            NSDate *cvDate = [NSDate dateWithTimeIntervalSince1970:date.doubleValue];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//            NSString *newDate = [formatter stringFromDate:cvDate];//新时间
//            [formatter release];
//            
//            NSBox *box = [[NSBox alloc] initWithFrame:NSMakeRect(x, y, 188, 150)];
//            [box setTitle:[NSString stringWithFormat:@"%@ %@", sendOrReceive, newDate]];
//            [box setTitlePosition:NSAtTop];
//            [box setTitleFont:[NSFont fontWithName:@"Lucida Grande" size:10.0]];
//            [box setBorderType:NSLineBorder];
//            [box setBoxType:NSBoxPrimary];
//            [messageView addSubview:box];
//            
//            
//            NSTextField *text_label = [[NSTextField alloc] init];
//            [text_label setFrame:NSMakeRect(0, 0, 180, 120)];
//            [text_label setBordered:NO];
//            [text_label setEditable:NO];
//            [text_label.cell setWraps:YES];
//            [text_label setFont:[NSFont fontWithName:@"Lucida Grande" size:12.0]];
//            [text_label setStringValue:text];
//            [box addSubview:text_label];
//            [text_label release];
//            [box release];
//            
//            y-=155.0;
//        }
//    }
//}
//
//- (void)addLabelToAddressView:(NSDictionary *)info
//{
//    if (info.count>0) {
//        
//        CGFloat x=22.0, y=460.0;
//        CGFloat a=0.0, b=0.0;
//        
//        for (int i=0; i<info.count; i++) {
//            
//            CGFloat ax=x+a, by=y+b;
//            
//            NSString *labelValue = [[info allKeys] objectAtIndex:i];
//            NSString *value = [[info allValues] objectAtIndex:i];
//            
//            NSTextField *labelValue_label = [[NSTextField alloc] init];
//            [labelValue_label setFrame:NSMakeRect(ax, by, 150, 17)];
//            [labelValue_label setBordered:NO];
//            [labelValue_label setEditable:NO];
//            [labelValue_label setFont:[NSFont fontWithName:@"Lucida Grande" size:10.0]];
//            [labelValue_label setStringValue:labelValue];
//            [addressInfoView addSubview:labelValue_label];
//            [labelValue_label release];
//            
//            NSTextField *value_label = [[NSTextField alloc] init];
//            [value_label setBordered:NO];
//            [value_label setEditable:NO];
//            [value_label.cell setWraps:YES];
//            NSFont *font = [NSFont fontWithName:@"Lucida Grande" size:10.0];
//            [value_label setFont:font];
//            NSDictionary *textAtt = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
//            
//            NSSize okSize = [MyDefinePath getOKSize:[value sizeWithAttributes:textAtt]];
//            
//            [value_label setFrame:NSMakeRect(ax+62, by-okSize.height+17, 100, okSize.height)];
//            [value_label setStringValue:value];
//            [addressInfoView addSubview:value_label];
//            [value_label release];
//            
//            b-=okSize.height+5;
//        }
//    }
//}
//
