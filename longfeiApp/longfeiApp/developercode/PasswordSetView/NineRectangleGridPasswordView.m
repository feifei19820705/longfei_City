//
//  NineRectangleGridPasswordView.m
//  feifei
//
//  Created by 206 on 13-7-9.
//  Copyright (c) 2013年 feifei. All rights reserved.
//

#import "NineRectangleGridPasswordView.h"
#import "LongCommon.h"

#define NineRectangleGrid @"NineRectangleGridPasswordView"

@interface NineRectangleGridPasswordView()
{
    UILabel* pPromptTextLabel;   //提示文本
}

@end

@implementation NineRectangleGridPasswordView

- (id)initWithFrame:(CGRect)frame withShowType:(PasswordType)nPasswordType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
//        [self setBackgroundColor:[UIColor yellowColor]];
        pPromptTextLabel = [[UILabel alloc] init];
        pPromptTextLabel.backgroundColor = [UIColor clearColor];
        pPromptTextLabel.textColor = [UIColor whiteColor];
        if (nPasswordType == ESet_Password)         //设置密码
        {
            
        }
        else if(nPasswordType == ECheck_PassWord)   //二次确认密码
        {
            
        }
        else if(nPasswordType == ELoginIn_PassWord) //登陆输入密码
        {
            
        }
        else if(nPasswordType == EOtherPassWordType) //其他
        {
            
        }
        
        NSUserDefaults* pUserDefaults = [NSUserDefaults standardUserDefaults];
        if ([pUserDefaults objectForKey:NineRectangleGrid])   //表示已经设置过
        {
            
        }
        else
        {
            
        }
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluesky.png"]];
        
        mutalearray = [[NSMutableArray array]retain];
        mutag = [[NSMutableArray array]retain ];
        resulttext = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, 100, 40)];
        
        [resulttext resignFirstResponder];
        resulttext.textColor = [UIColor whiteColor];
        [self  addSubview:resulttext];
        
        
        for (int i=0; i<9; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(26+(i%3)*98, 126+(i/3)*98, 72, 72)];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setBackgroundImage:[UIImage imageNamed:@"track.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateSelected];
            button.userInteractionEnabled= NO;//用户交互
            button.alpha = 0.9;
            button.tag = i+10000;
            [self addSubview:button];
            [mutalearray addObject:button];
        }
    }
    return self;
}

- (void)setNeedsLayout
{
    NSLog(@"--------- %@",NSStringFromSelector(_cmd));
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluesky.png"]];

    if (UIScreen_W > UIScreen_H)   //横屏
    {
        self.frame = CGRectMake(0, 0, UIScreen_W, UIScreen_H);
//        resulttext.frame = CGRectMake(126+3*98, 26, 100, 40);
        int num = [mutalearray count];
        for (int i=0; i<num; i++)
        {
            UIButton *button = (UIButton*)[mutalearray objectAtIndex:i];
            [button setFrame:CGRectMake(126+(i%3)*98, 26+(i/3)*98, 72, 72)];
            button.userInteractionEnabled= NO;//用户交互
        }
        
    }
    else       //竖屏
    {
        
        self.frame = CGRectMake(0, 0, UIScreen_W, UIScreen_H);
//        resulttext = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, 200, 40)];
        int num = [mutalearray count];
        for (int i=0; i<num; i++)
        {
            UIButton *button = (UIButton*)[mutalearray objectAtIndex:i];
            [button setFrame:CGRectMake(26+(i%3)*98, 126+(i/3)*98, 72, 72)];
            button.userInteractionEnabled= NO;//用户交互
        }
    }

}
- (void)layoutIfNeeded
{
    NSLog(@"--------- %@",NSStringFromSelector(_cmd));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (UIScreen_W > UIScreen_H)   //横屏
    {
        int num = [mutalearray count];
        for (int i=0; i<num; i++)
        {
            UIButton *button = (UIButton*)[mutalearray objectAtIndex:i];
            [button setFrame:CGRectMake(126+(i%3)*98, 26+(i/3)*98, 72, 72)];
            button.userInteractionEnabled= NO;//用户交互
        }

    }
    else       //竖屏
    {
        int num = [mutalearray count];
        for (int i=0; i<num; i++)
        {
            UIButton *button = (UIButton*)[mutalearray objectAtIndex:i];
            [button setFrame:CGRectMake(26+(i%3)*98, 126+(i/3)*98, 72, 72)];
             button.userInteractionEnabled= NO;//用户交互
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint point= [[touches anyObject]locationInView:self];
    curentpoint = point;
    for (UIButton *thisbutton in mutalearray) {
        CGFloat xdiff =point.x-thisbutton.center.x;
        CGFloat ydiff=point.y - thisbutton.center.y;
        //按钮点击成功
        if (fabsf(xdiff) <36 &&fabsf (ydiff) <36){
            
            NSLog(@"%d",thisbutton.tag-9999);
            resulttext.text = [NSString stringWithFormat:@"%d",thisbutton.tag-9999];
            resulttext.text = [resulttext.text stringByAppendingString:resulttext.text];
            
            if (!thisbutton.selected) {
                thisbutton.selected = YES;
                [mutag  addObject:thisbutton];
}
        
}
}
    [self setNeedsDisplay];
    [self addstring];
//    NSLog(@"shuzhu  %@",mutag);

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIButton *thisButton in mutalearray) {
        [thisButton setSelected:NO];
    }
    [mutag removeAllObjects];
    [self setNeedsDisplay];
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGPoint begainpoint=[[touches anyObject]locationInView:self];
//    begainpoint = [[touches anyObject]locationInView:self];
//
//    for (UIButton *thisbutton in mutalearray) {
//    
//    CGFloat xdiff =begainpoint.x-thisbutton.center.x;
//    CGFloat ydiff=begainpoint.y - thisbutton.center.y;
//    
//    if (fabsf(xdiff) <36 &&fabsf (ydiff) <36&&fabsf(xdiff)<0&&fabsf (ydiff)<0){
//         if (!thisbutton.selected) {
//                thisbutton.selected = YES;
//                [mutag  addObject:thisbutton];
//}
//}
//}
//
//    [self setNeedsDisplay];
//    [self addstring];
//}
//
-(void)drawRect:(CGRect)rect{
  CGContextRef  contextref = UIGraphicsGetCurrentContext();
    UIButton *buttonn;
    UIButton *buttonn1;
    
    if (mutag.count!=0) {
        buttonn = mutag[0];
        [[UIColor  redColor]set];
        CGContextSetLineWidth(contextref, 15);
        CGContextMoveToPoint(contextref, buttonn.center.x, buttonn.center.y);
        
        for (int t=0; t<mutag.count; t++) {
            buttonn1 = mutag[t];
            CGContextAddLineToPoint(contextref, buttonn1.center.x, buttonn1.center.y);
           
        }
        CGContextAddLineToPoint(contextref, curentpoint.x, curentpoint.y); 
       
    }
     CGContextStrokePath(contextref);
}
-(void)addstring{
    UIButton *strbutton;
    NSString *string=@"";
    
    for (int t=0; t<mutag.count; t++) {
        strbutton = mutag[t];
         string= [string stringByAppendingFormat:@"%d",strbutton.tag-9999];
        
    }

resulttext.text = string;

}




@end
