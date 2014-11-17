//
//  LocalNotificationCenter.h
//  iosNewNavi
//
//  Created by gaoying on 14-1-21.
//  Copyright (c) 2014年 delon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationCenter : NSObject

+(LocalNotificationCenter *)sharedLocalNotificationCenter;
-(void)localNotificationUpdate:(NSString*)pDateString withNotificationContent:(NSString*)pLocalContent;
-(void)cancellocalNotification;
@end
