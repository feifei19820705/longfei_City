//
//  CommonClass.m
//  OnlineNavigation
//
//  Created by feifei on 12-7-3.
//  Copyright (c) 2012年 feifei. All rights reserved.
//

#import "CommonClass.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

@implementation CommonClass
static MBProgressHUD *_progressHUD;

+(NSInteger)getTimeInterval:(CommonTimeType)nCommonTimeType withYear:(NSInteger)nYear withMonth:(NSInteger)nMonth withDay:(NSInteger)nDay
{
    if (nYear == 0 || nMonth <= 0 || nMonth > 12 || nDay <= 0 || nDay > 31)
    {
        return -1;
    }
    NSInteger nTimeValue = 0;
    
    NSDate *now=[NSDate new];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    NSInteger nCurrentYear = [comps year];
    if (nYear < nCurrentYear)
    {
        nYear = nCurrentYear;
    }
    
    NSDateComponents *pDateComps = [[NSDateComponents alloc] init];
    [pDateComps setYear:nYear];
    [pDateComps setMonth:nMonth];
    [pDateComps setDay:nDay];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:pDateComps];
    NSLog(@"data === %@",date.description);
    [pDateComps release];
    
    //  先定义一个遵循某个历法的日历对象
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //  根据两个时间点，定义NSDateComponents对象，从而获取这两个时间点的时差
    NSDateComponents *dateComponents = nil;
    switch (nCommonTimeType) {
        case ECommon_Time_year:
        {
            dateComponents = [greCalendar components:NSYearCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.year;
        }
            break;
        case ECommon_Time_month:
        {
            dateComponents = [greCalendar components:NSMonthCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.month;
        }
            break;
        case ECommon_Time_Day:
        {
            dateComponents = [greCalendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.day;
        }
            break;
        case ECommon_Time_Hour:
        {
            dateComponents = [greCalendar components:NSHourCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.hour;
        }
            break;
        case ECommon_Time_Minute:
        {
            dateComponents = [greCalendar components:NSMinuteCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.minute;
        }
            break;
        case ECommon_Time_second:
        {
            dateComponents = [greCalendar components:NSSecondCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.second;
            
        }
            break;
            
        default:        //默认返回间隔的秒数
        {
            dateComponents = [greCalendar components:NSSecondCalendarUnit fromDate:[NSDate date] toDate:date options:0];
            nTimeValue = dateComponents.second;
//测试用
//            dateComponents = [greCalendar components:NSYearCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.year;
//            NSLog(@"year=== %i",nTimeValue);
//            
//            dateComponents = [greCalendar components:NSMonthCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.month;
//            NSLog(@"month=== %i",nTimeValue);
//            
//            dateComponents = [greCalendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.day;
//            NSLog(@"day=== %i",nTimeValue);
//            
//            dateComponents = [greCalendar components:NSHourCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.hour;
//            NSLog(@"hour=== %i",nTimeValue);
//            
//            dateComponents = [greCalendar components:NSMinuteCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.minute;
//            NSLog(@"minute=== %i",nTimeValue);
//            
//            dateComponents = [greCalendar components:NSSecondCalendarUnit fromDate:[NSDate date] toDate:date options:0];
//            nTimeValue = dateComponents.second;
//            NSLog(@"second=== %i",nTimeValue);
        }
            break;
    }
    
    if (nTimeValue < 0)    //表示是过去的时间，因此需重新设置
    {
        nYear = nYear + 1;
        nTimeValue = [CommonClass getTimeInterval:nCommonTimeType withYear:nYear withMonth:nMonth withDay:nDay];
    }
    
    //NSLog(@"year == %i,month == %i,day == %i,hour == %i,min == %i,sencod == %i",dateComponents.year,dateComponents.month,dateComponents.day,dateComponents.hour,dateComponents.minute,dateComponents.second);
    return nTimeValue;
}

//显示只有文字的提示框
+ (void)showOnlyTextProgressHUD:(UIView*)view text:(NSString*)text time :(NSInteger)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:time];
}

//显示提示框
+ (void)startProgressHUD:(UIView *)view text:(NSString *)text
{
    if (_progressHUD){
		[_progressHUD removeFromSuperview];
		_progressHUD = nil;
	}
    _progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:_progressHUD];
    [view bringSubviewToFront:_progressHUD];
    _progressHUD.labelText = text;
    [_progressHUD show:NO];
}

//显示提示框
+ (void)startProgressHUD:(UIView *)view text:(NSString *)text frame:(CGRect)frame
{
    if (_progressHUD){
		[_progressHUD removeFromSuperview];
		_progressHUD = nil;
	}
    _progressHUD = [[MBProgressHUD alloc] initWithView:view];
    _progressHUD.frame = frame;
    [view addSubview:_progressHUD];
    [view bringSubviewToFront:_progressHUD];
    _progressHUD.labelText = text;
    [_progressHUD show:NO];
}

//隐藏提示框
+ (void)endProgressHUD
{
    if (_progressHUD){
		[_progressHUD removeFromSuperview];
		_progressHUD = nil;
	}
}

//秒转换小时
+ (NSString*)ConvertSecondToHour:(NSInteger)seconds
{
    if (seconds<=0) {
        return @"00:00:00";
    }
    int _hours = seconds / 3600;
    int _minutes = (seconds % 3600) / 60;
    int _seconds = seconds % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",_hours,_minutes,_seconds];
}

//秒转换小时
+ (NSString*)ConvertSecondToStringHour:(NSInteger)seconds isShowUnit:(BOOL)showUnit
{
    if (seconds<=0) {
        return @"0";
    }
    int _hours = seconds / 3600;
    int _minutes = (seconds % 3600) / 60;
    int _seconds = seconds % 60;

    NSMutableString *hourString = [[[NSMutableString alloc] init] autorelease];
    
    if (showUnit) {
        if (_hours>0) {
            [hourString appendFormat:@"%d小时",_hours];
        }
        if (_minutes>0) {
            [hourString appendFormat:@"%d分钟",_minutes];
        }
        if (_seconds >0) {
            [hourString appendFormat:@"%d秒",_seconds];
        }
    }
    else
    {
        if (_hours >9) {
            [hourString appendFormat:@"%d:",_hours];
        }
        else{
            [hourString appendFormat:@"0%d:",_hours];
        }
        
        if (_minutes >9) {
            [hourString appendFormat:@"%d:",_minutes];
        }
        else{
            [hourString appendFormat:@"0%d:",_minutes];
        }
        
        if (_seconds >9) {
            [hourString appendFormat:@"%d",_seconds];
        }
        else{
            [hourString appendFormat:@"0%d",_seconds];
        }
    }

    return hourString;
}

//米转公里
+ (NSString*)ConvertMeterToKilometerToString : (NSInteger)meters
{
    if (meters>1000){
        return [NSString stringWithFormat:@"%.1f 公里",meters/1000.0];
    }else if(meters>=0){
        return [NSString stringWithFormat:@"%d 米",meters];
    }else {
        return @"0";
    }
}

//米转换千米
+ (NSString*)ConvertMeterToKilometer:(NSInteger)meters
{
    if (meters>1000){
        return [NSString stringWithFormat:@"%.1f km",meters/1000.0];
    }else if(meters>=0){
        return [NSString stringWithFormat:@"%d m",meters];
    }else {
        return @"0";
    }
}

//获得时差精确到秒
+ (int)getTimeDifference :(NSDate*)oldDate
{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"MMddHHmmss"];//这里去掉 具体时间 保留日期
    NSString *date = [formater stringFromDate:[NSDate date]];
    NSString *_date = [formater stringFromDate:oldDate];
    [formater release];
    NSLog(@"%@",date);
    NSLog(@"%@",_date);
    NSLog(@"%d",[date intValue]);
    NSLog(@"%d",[_date intValue]);
    return [date intValue] - [_date intValue];
}

//获得当前时间
+ (NSString*)getCurrentTime
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM-dd HH:mm"];//这里去掉 具体时间 保留日期
    NSString *data = [formater stringFromDate:curDate];
    [formater release];
    return data;
}

//得到当前时间
+(NSString*)GregorianCurrentTime
{
    NSDate *now=[NSDate new];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSLog(@"格林威治时间  year == %i,month == %i,day == %i,hour == %i,min == %i,sencod == %i",year,month,day,hour,min,sec);
    return [NSString stringWithFormat:@"%i-%i-%i-%i-%i-%i",year,month,day,hour,min,sec];
}

//得到该月有多少天
+ (NSInteger) numberDaysInMonth:(NSInteger) month ofYear:(NSInteger) year
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString* str = [NSString stringWithFormat:@"%d-%d",year,month];
    NSDate* date = [formatter dateFromString:str];
    [formatter release];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate: date];
    return range.length;
}

//获得当前时间的指定格式
+ (NSString*)getCurrentTimeByStyle :(NSString*)style
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:style];//这里去掉 具体时间 保留日期
    NSString *data = [formater stringFromDate:curDate];
    [formater release];
    return data;
}


//返回当前时间的IntValue
+ (NSString*)returnCurrentTimeToIntValue
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMdd"];//这里去掉 具体时间 保留日期
    NSString *data = [formater stringFromDate:curDate];
    [formater release];
    return data;
}

//获得屏幕截图
+ (UIImage*)getScreenshotImage 
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"Screen_Image"];
    return [UIImage imageWithData:data];
}

//设置屏幕截图
+ (void)setScreenshotImage : (UIImage*)image
{
    //以png格式返回指定图片的数据
    NSData *data = UIImagePNGRepresentation(image);

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  
    [userDefaults setObject:data forKey:@"Screen_Image"];
    [userDefaults synchronize];
}

//Unicode 转换为中文
+ (NSString *)replaceUnicode:(NSString *)unicodeStr 
{  
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];  
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];  
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];  
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];  
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData  
                                                           mutabilityOption:NSPropertyListImmutable   
                                                                     format:NULL  
                                                           errorDescription:NULL];  
    
    //NSLog(@"Output = %@", returnStr);  
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];  
}  

//获得版本信息
+ (NSString*)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

//界面跳转动画
+(void)pushController :(UIViewController*)viewController navigationController:(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions
{
    [UIView transitionWithView:navigationController.view duration:0.6
					   options:animationOptions   			 
					animations:^{
						[navigationController pushViewController:viewController animated:NO];
					}
					completion:NULL];
}

//界面返回动画
+(void)popController :(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions
{
    [UIView transitionWithView:navigationController.view duration:0.6
					   options:animationOptions   			 
					animations:^{
						[navigationController popViewControllerAnimated:NO];
					}
					completion:NULL];
}

//返回到根界面动画
+(void)popToRootController :(UINavigationController*)navigationController :(UIViewAnimationOptions)animationOptions
{
    [UIView transitionWithView:navigationController.view duration:0.8
					   options:animationOptions   			 
					animations:^{
						[navigationController popToRootViewControllerAnimated:NO];
					}
					completion:NULL];
}

//记录日志
+(void)printLogToFile:(NSString *)log
{
    NSString *currentTime = [CommonClass getCurrentTimeByStyle:@"yyyy-MM-dd HH:mm:ss:SSS"];
    
    [self printLogToTheFile:@"NSLog.txt" log:[NSString stringWithFormat:@"%@:%@",currentTime,log]];
}



//向指定文件写入数据
+(void)printLogToTheFile :(NSString*)file log :(NSString*)log
{
    NSFileHandle *inFile;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //第一：读取documents路径的方法：
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; 
    
    //得到documents的路径，为当前应用程序独享
    NSString *documentDirectory = [paths objectAtIndex:0]; 
    
    //fileName是要查找的文件名字，文件全名
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:file]; 
    
    //判断是否存在文件，如果不存在则创建
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];  
    }

    //打开fileB用于更新操作
    inFile = [NSFileHandle fileHandleForWritingAtPath:filePath];

    if(inFile == nil)
    {
        NSLog(@"Open of fileB for writing failed");
        return;
    }

    //找到并定位到outFile的末尾位置(在此后追加文件)
    [inFile seekToEndOfFile];
    log = [NSString stringWithFormat:@"\n%@",log];
    //读取inFile并且将其内容写到outFile中
    [inFile writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
    //关闭读写文件
    [inFile closeFile];
}

//获得流量信息
+ (NSArray *)getDataCounters
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    NSString *name=[[[NSString alloc]init]autorelease];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            NSLog(@"ifa_name %s == %@\n", cursor->ifa_name,name);
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent += networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }
                if ([name hasPrefix:@"pdp_ip"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent += networkStatisc->ifi_obytes;
                    WWANReceived += networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
}

//获取流量
+(double)getByte
{
    NSArray *array = [CommonClass getDataCounters];
    return [[array objectAtIndex:0] floatValue] + [[array objectAtIndex:1] floatValue];
}

//Byte转换String
+ (NSString*)convertByteToString : (float)byte
{
    NSString *sByte = nil;
    if (byte < 1024.0) {
        sByte = [NSString stringWithFormat:@"%.1f B",byte];
    }else if (byte > 1024.0 && byte < 1024.0 * 1024.0){
        sByte = [NSString stringWithFormat:@"%.1f K",byte / 1024.0];
    }else if(byte > 1024.0 * 1024.0){
        sByte = [NSString stringWithFormat:@"%.1f M",byte / (1024.0 * 1024)];
    }
    return sByte;
}

@end
