//
//  LongCommon.h
//  navidog4x
//
//  Created by heweihua on 12-10-31.
//
//

#ifndef navidog4x_Common_h
#define navidog4x_Common_h


#define StateBar_H 20
#define UIScreen_W [[UIScreen mainScreen] bounds].size.width
#define UIScreen_H [[UIScreen mainScreen] bounds].size.height
#define UIScreen_Frame CGRectMake(0, 0, UIScreen_W, UIScreen_H) // 非MainViewController
#define UIScreen_Frame_MainController  CGRectMake(0, StateBar_H, UIScreen_W, UIScreen_H) // 在MainViewController

#define ROUTE_VIEW_WEBVIEW_HEHGHT 78

//if (__IPHONE_5_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED){
//}

#define __IOS_4_0     @"4.0"
#define __IOS_5_0     @"5.0"
#define __IOS_6_0     @"6.0"
#define __IOS_7_0     @"7.0"

#define IOS_Greater_Or_Equal(ios) ( (( [ios compare:[UIDevice currentDevice].systemVersion] == NSOrderedAscending) ? YES : NO) || (( [ios compare:[UIDevice currentDevice].systemVersion] == NSOrderedSame) ? YES : NO) )


// 判断iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断itouch
#define iPod_touch [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] 
// 安全释放内存宏定义
#define SAFE_RELEASE(e) { if ((e) != nil)  {[(e) release]; (e)=nil; } }




NSUInteger DeviceSystemMajorVersion(void);
NSUInteger DeviceSystemMajorVersion(void)
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}
#define MY_MACRO_NAME (DeviceSystemMajorVersion() < 7)

#endif
