//
//  LocalNotificationCenter.m
//  iosNewNavi
//
//  Created by gaoying on 14-1-21.
//  Copyright (c) 2014年 delon. All rights reserved.
//

#import "LocalNotificationCenter.h"

#define NAVI_LOCALNOTIFICATION @"NAVI_LOCALNOTIFICATION"

static LocalNotificationCenter *_sharedCenter = nil;
@implementation LocalNotificationCenter
+(LocalNotificationCenter *)sharedCenter
{
    if(!_sharedCenter)
    {
        _sharedCenter = [[LocalNotificationCenter alloc] init];
    }
    return _sharedCenter;
}
-(id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}
-(void)update
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSDate *now=[NSDate new];
    UILocalNotification *_localNotification = [[UILocalNotification alloc] init];
    _localNotification.fireDate=[now dateByAddingTimeInterval:7*24*3600];
    _localNotification.timeZone=[NSTimeZone defaultTimeZone];
    _localNotification.alertBody=@"您已经7天没有运动了，您的小伙伴知道么?";
    _localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:_localNotification];
    [now release];
    [_localNotification release];
}
-(void)cancel
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
@end
