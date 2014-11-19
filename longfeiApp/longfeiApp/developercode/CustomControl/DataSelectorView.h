//
//  DataSelectorView.h
//  longfeiApp
//
//  Created by yangcf on 14-11-19.
//  Copyright (c) 2014年 yangcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataSelectorView : UIView

/**********************************************************
 函数名称：initDataSelector    实例方法
 函数描述：初始化
 输入参数：N/A
 输出参数：N/A
 返回值： 得到日期选择器对象的实例
 **********************************************************/
-(id)initDataSelector;

+(void)showDataSelector:(UIView*)pView;

@end
