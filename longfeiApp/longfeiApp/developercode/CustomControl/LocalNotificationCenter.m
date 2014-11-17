//
//  LocalNotificationCenter.m
//  iosNewNavi
//
//  Created by feifei on 14-1-21.
//  Copyright (c) 2014年 feifei. All rights reserved.
//

#import "LocalNotificationCenter.h"
#import "CommonClass.h"

static LocalNotificationCenter *_sharedCenter = nil;

@implementation LocalNotificationCenter

+(instancetype)sharedLocalNotificationCenter
{
    if(!_sharedCenter)
    {
        _sharedCenter = [[LocalNotificationCenter alloc] init];
    }
    return _sharedCenter;
}

-(void)localNotificationUpdate:(NSString*)pDateString withNotificationContent:(NSString*)pLocalContent
{
    NSArray* pArray = [pDateString componentsSeparatedByString:@"-"];
    NSLog(@"pArray ---- %@",pArray);
    
    NSInteger nSecond = 0;
    if (pArray)
    {
        NSString* pYearString = [pArray objectAtIndex:0];
        NSString* pMonthString = [pArray objectAtIndex:1];
        NSString* pDayString = [pArray objectAtIndex:2];
        nSecond = [CommonClass getTimeInterval:ECommon_Time_second withYear:[pYearString integerValue] withMonth:[pMonthString integerValue] withDay:[pDayString integerValue]];
    }
    if (nSecond <= 0)
    {
        return;
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSDate *now = [NSDate new];
    UILocalNotification *_localNotification = [[UILocalNotification alloc] init];
    _localNotification.fireDate = [now dateByAddingTimeInterval:nSecond];
    _localNotification.timeZone = [NSTimeZone defaultTimeZone];
    _localNotification.alertBody = pLocalContent;
    _localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:_localNotification];
    [now release];
    [_localNotification release];
}

-(void)cancellocalNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
