//
//  AppDelegate.h
//  longfeiApp
//
//  Created by yangcf on 14-10-22.
//  Copyright (c) 2014年 yangcf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewControllor.h"

enum PhoneType     //电话类型
{
    ECMCC,      //中国移动通信-----chinamobile
    ECUCC,      //中国联通通讯-----chinaunicom
    ECTCC,      //中国电信------CHINATELECOM
    EOtherType  //其他
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* _pSaveDataString;
    enum PhoneType _nPhoneType;      //电话类型
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString* _pSaveDataString;
@property (nonatomic) enum PhoneType nPhoneType;      //电话类型
@property (nonatomic,retain) MainViewControllor* pMainViewControllor;

@end

