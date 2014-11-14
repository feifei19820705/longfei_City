//
//  CommonClass.h
//  OnlineNavigation
//
//  Created by weilihua on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommonClass : NSObject

/*
 *  时间字符转换
 */
+ (NSString*)ConvertSecondToHour:(NSInteger)seconds;

//秒转换小时
+ (NSString*)ConvertSecondToStringHour:(NSInteger)seconds isShowUnit:(BOOL)showUnit;

//米转公里
+ (NSString*)ConvertMeterToKilometerToString : (NSInteger)meters;

/*
 *  米转换千米
 */
+ (NSString*)ConvertMeterToKilometer:(NSInteger)meters;

//获得时差精确到秒
+ (int)getTimeDifference :(NSDate*)oldDate;

/*
 *  获得当前时间
 */
+ (NSString*)getCurrentTime;

+ (NSString*)getCurrentTimeByStyle :(NSString*)style;

//返回当前时间的IntValue
+ (NSString*)returnCurrentTimeToIntValue;

//获得屏幕截图
+ (UIImage*)getScreenshotImage;

//设置屏幕截图
+ (void)setScreenshotImage : (UIImage*)image;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;


//获得版本信息
+ (NSString*)getVersion;

//界面跳转动画
+(void)pushController :(UIViewController*)viewController navigationController:(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions;

//界面返回动画
+(void)popController :(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions;

//返回到根界面动画
+(void)popToRootController :(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions;

////打印log
//+(void)printLogToFile :(NSString*)logText;
+(void)printLogToFile : (NSString*)log;

//获取流量
+ (NSArray *)getDataCounters;

//获取流量
+ (double)getByte;

//Byte转换String
+ (NSString *)convertByteToString : (float)byte;


@end
