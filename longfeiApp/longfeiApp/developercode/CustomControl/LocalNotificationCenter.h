//
//  LocalNotificationCenter.h
//  iosNewNavi
//
//  Created by feifei on 14-1-21.
//  Copyright (c) 2014年 feifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationCenter : NSObject

/**********************************************************
 函数名称：sharedLocalNotificationCenter     静态方法
 函数描述：得到该对象的实例
 输入参数：N/A
 输出参数：N/A
 返回值： 得到本地推送对象的实例
 **********************************************************/
+(instancetype)sharedLocalNotificationCenter;

/**********************************************************
 函数名称：localNotificationUpdate       实例方法
 函数描述：更新本地通知
 输入参数：（1）(NSString*)pDateString    日期字符串，注意  格式必须为 yy-mm-dd（年-月-日）,否则会解析失败
         （2）withNotificationContent:(NSString*)pLocalContent   本地推送的内容
 输出参数：N/A
 返回值： N/A
 **********************************************************/
-(void)localNotificationUpdate:(NSString*)pDateString withNotificationContent:(NSString*)pLocalContent;

/**********************************************************
 函数名称：cancellocalNotification       实例方法
 函数描述：取消本地所有的通知
 输入参数：N/A
 输出参数：N/A
 返回值： N/A
 **********************************************************/
-(void)cancellocalNotification;
@end
