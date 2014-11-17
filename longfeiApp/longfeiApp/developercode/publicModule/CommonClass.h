//
//  CommonClass.h
//  OnlineNavigation
//
//  Created by feifei on 12-7-3.
//  Copyright (c) 2012年 feifei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _CommonTimeType             //本地通知的时间的类型
{
    ECommon_Time_year = 101,
    ECommon_Time_month,
    ECommon_Time_Day,
    ECommon_Time_Hour,
    ECommon_Time_Minute,
    ECommon_Time_second
}CommonTimeType;

@interface CommonClass : NSObject

+(NSInteger)getTimeInterval:(CommonTimeType)nCommonTimeType withYear:(NSInteger)nYear withMonth:(NSInteger)nMonth withDay:(NSInteger)nDay;

/**********************************************************
 函数名称：numberDaysInMonth     静态方法
 函数描述：得到传入的月有多少天
 输入参数：（1）(NSInteger) month       传入的月份
         （2）ofYear:(NSInteger) year 传入的年份
 输出参数：N/A
 返回值： 返回天数
 **********************************************************/
+ (NSInteger) numberDaysInMonth:(NSInteger) month ofYear:(NSInteger) year;

//得到当前时间
+(NSString*)GregorianCurrentTime;

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
