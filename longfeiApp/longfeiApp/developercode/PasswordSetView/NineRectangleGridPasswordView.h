//
//  NineRectangleGridPasswordView.h
//  feifei
//
//  Created by 206 on 13-7-9.
//  Copyright (c) 2013年 feifei. All rights reserved.
//

/*
 九宫格密码视图
 */

#import <UIKit/UIKit.h>
typedef enum _PasswordType    //密码类型
{
    ESet_Password,      //设置（或者修改）密码
    ECheck_PassWord,    //二次确认密码
    ELoginIn_PassWord,  //输入密码
    EOtherPassWordType  //其他
}PasswordType;

@interface NineRectangleGridPasswordView : UIView{

    NSMutableArray *mutalearray;
     NSMutableArray *mutag;
    CGPoint curentpoint;
    UITextField *resulttext;
}

- (id)initWithFrame:(CGRect)frame withShowType:(PasswordType)nPasswordType;

@end
