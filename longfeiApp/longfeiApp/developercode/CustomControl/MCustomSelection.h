//
//  MCustomSelection.h
//  iosNewNavi
//
//  Created by gaoying on 13-9-18.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCustomSelection : UIControl
{
    UIImageView *_backgroundImageView;
}
@property(nonatomic,assign)int numberOfSelections;
@property(nonatomic,assign)int selectIndex;
@property(nonatomic,assign)int selection_width;
-(void)selectionsWithTitle:(NSArray *)titles;

-(id)initWithWidth:(CGFloat)width;
@end
