//
//  SQLSelectLan.h
//  DataRecoveryUI
//
//  Created by 全晖林 on 14-6-30.
//  Copyright (c) 2014年 全晖林. All rights reserved.
//

//电话薄
static NSString *SQLAddressBookLan  = @"select ROWID, First, Last, Organization from ABPerson";
static NSString *SQLAddressValueLan = @"select record_id, label, value from ABMultiValue";
static NSString *SQLAddressLabelLan = @"select rowid, value from ABMultiValueLabel";
static NSString *SQLAddressEntryLan = @"select parent_id, value from ABMultiValueEntry";

//呼叫历史
static NSString *SQLCallHistoryLan  = @"select address, date, duration, flags from call";

//Note
static NSString *SQLNotesLan        = @"select a.ZCREATIONDATE, a.ZTITLE, b.ZCONTENT from ZNOTE a left join ZNOTEBODY b where a.Z_PK=b.Z_PK";

//网页
static NSString *SQLSafariLan       = @"select title, url from bookmarks where url is not null";

//SMS
static NSString *SQLMsg_Group       = @"select ROWID from msg_group";
static NSString *SQLMsg_Member      = @"select group_id, address from group_member";
static NSString *SQLMsg_Message     = @"select group_id, date, text, flags from message";

//日历
static NSString *SQLCalendarLan     = @"select a.title, b.summary, b.description, b.completion_date from Calendar a, CalendarItem b where a.ROWID=b.calendar_id";

//获取表数量
static NSString *SQLTableNumberLan  = @"select count(*) from sqlite_master where type='table'";

//Photos
//iphone
static NSString *SQLPhotosIphoneLan = @"select captureTime, recordModDate, directory, filename from Photo";
//ipad
static NSString *SQLPhotosIpadLan   = @"select ZDATECREATED, ZMODIFICATIONDATE, ZDIRECTORY, ZFILENAME from ZGENERICASSET";

//Vedio
static NSString *SQLVedioLan        = @"select ZDATE, ZPATH from ZRECORDING";


//z additional asset attributes//z generic asset