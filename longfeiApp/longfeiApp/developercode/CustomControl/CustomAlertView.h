//
//  AlertView.h
//  iosPadNavi
//
//  Created by delon on 13-7-2.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertViewBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@interface CustomAlertView : UIAlertView
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
@property(nonatomic,copy) AlertViewBlock alertBlock;
@end
