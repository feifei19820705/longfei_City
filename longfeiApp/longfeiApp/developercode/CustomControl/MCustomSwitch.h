//
//  MCustomSwitch.h
//  iosNewNavi
//
//  Created by gaoying on 13-9-18.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCustomSwitch : UIControl

@property(nonatomic,retain)UIImage *leftIconOn;
@property(nonatomic,retain)UIImage *leftIconOff;
@property(nonatomic,retain)UIImage *rightIconOn;
@property(nonatomic,retain)UIImage *rightIconOff;
@property(nonatomic,retain)NSString  *leftTitleOn;
@property(nonatomic,retain)NSString  *leftTitleOff;

@property(nonatomic,getter=isOn) BOOL on;

- (id)initWithFrame:(CGRect)frame;              
- (id)initWithBackgroundImage:(UIImage *)backgroundImage;
- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end
