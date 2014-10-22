//
//  MainViewControllor.h
//  生活小助手
//
//  Created by feifei on 14-2-12.
//  Copyright (c) 2014年 feifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewControllor : UIViewController
{
    UITabBar* pTabBar;
    UITextField* pShowPhoneTextField;
    UILabel* pPhoneLabel;
    UILabel* pPhoneTypeLabel;
    UIButton* pFinishButton;
}

@property(nonatomic)BOOL accessGranted;    //通讯录是否获取成功

//单例该对象
+(instancetype)ShareMainControllorInstance;

-(void)ShowUsersPhoneInfo:(BOOL)bIsShow;    //显示用户使用信息


@end
