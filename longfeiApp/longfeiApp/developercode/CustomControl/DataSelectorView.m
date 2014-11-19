//
//  DataSelectorView.m
//  longfeiApp
//
//  Created by yangcf on 14-11-19.
//  Copyright (c) 2014年 yangcf. All rights reserved.
//

#import "DataSelectorView.h"
#import "LongCommon.h"

@interface DataSelectorView()
+(void)changeDatePicker:(UIDatePicker*)pDateSender;       //改变日期选择器的视图样式
@end

static DataSelectorView* pDataSelectorView = nil;

@implementation DataSelectorView

-(id)initDataSelector
{
    if (self == [super init]) {
        self.frame = CGRectMake(0, 0, UIScreen_W, UIScreen_H);
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6;
        
        UIDatePicker* pDataPicker = [[UIDatePicker alloc] init];
        pDataPicker.frame = CGRectMake(0, UIScreen_H - pDataPicker.frame.size.height, pDataPicker.frame.size.width, pDataPicker.frame.size.height);
        pDataPicker.datePickerMode = UIDatePickerModeDate;
        [pDataPicker setHidden:NO];
        NSDateComponents *pDateComps = [[NSDateComponents alloc] init];
        [pDateComps setYear:1900];
        [pDateComps setMonth:1];
        [pDateComps setDay:1];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *minDate = [gregorian dateFromComponents:pDateComps];
        
        [pDateComps setYear:2099];
        [pDateComps setMonth:1];
        [pDateComps setDay:1];
        NSDate *maxDate = [gregorian dateFromComponents:pDateComps];
        
        pDataPicker.minimumDate = minDate;
        pDataPicker.maximumDate = maxDate;
        
        [pDateComps setYear:1985];
        [pDateComps setMonth:1];
        [pDateComps setDay:21];
        NSDate *CurrentDate = [gregorian dateFromComponents:pDateComps];
        
        [pDataPicker setDate:CurrentDate animated:YES];

        [pDateComps release];
        [gregorian release];
        
        [pDataPicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:pDataPicker];
        [pDataPicker release];
    }
    return self;
}

+(void)showDataSelector:(UIView*)pView
{
    @synchronized(self)
    {
        if (pDataSelectorView == nil)
        {
            pDataSelectorView = [[self alloc] init];
        }
    }
    if (pDataSelectorView) {
        if (pDataSelectorView.superview)
        {
            [pDataSelectorView removeFromSuperview];
        }
         NSLog(@"当前的日期是  ====== %@",[NSDate date]);
        pDataSelectorView.frame = CGRectMake(0, 0, UIScreen_W, UIScreen_H);
//        pDataSelectorView.backgroundColor = [UIColor blackColor];
//        pDataSelectorView.alpha = 0.6;
        
        UIDatePicker* pDataPicker = [[UIDatePicker alloc] init];
        pDataPicker.frame = CGRectMake(0, UIScreen_H - pDataPicker.frame.size.height, pDataPicker.frame.size.width, pDataPicker.frame.size.height);
        pDataPicker.datePickerMode = UIDatePickerModeDate;
        //设置为指定时间
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //设置日期格式
//        NSString *date = @"1900-1-1";
//        NSDate *now = [dateFormatter dateFromString:date];
//        [pDataPicker setDate:now animated:YES];
        pDataPicker.timeZone = [NSTimeZone localTimeZone];
        NSLog(@"localTimeZone =======  %@",[NSTimeZone localTimeZone]);
        NSLog(@"localTimeZone =======  %@",[NSTimeZone systemTimeZone]);
        NSLog(@"localTimeZone =======  %@",[NSTimeZone defaultTimeZone]);
        
        NSDateComponents *pDateComps = [[NSDateComponents alloc] init];
        [pDateComps setYear:1900];
        [pDateComps setMonth:1];
        [pDateComps setDay:1];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *minDate = [gregorian dateFromComponents:pDateComps];
        
        [pDateComps setYear:2099];
        [pDateComps setMonth:1];
        [pDateComps setDay:1];
        NSDate *maxDate = [gregorian dateFromComponents:pDateComps];
        
        pDataPicker.minimumDate = minDate;
        pDataPicker.maximumDate = maxDate;
        
        [pDateComps setYear:1985];
        [pDateComps setMonth:1];
        [pDateComps setDay:21];
        NSDate *CurrentDate = [gregorian dateFromComponents:pDateComps];
        
        [pDataPicker setDate:CurrentDate animated:YES];
        
        [pDateComps release];
        [gregorian release];
        
        [pDataPicker addTarget:pDataSelectorView action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
        [DataSelectorView changeDatePicker:pDataPicker];
        [pDataSelectorView addSubview:pDataPicker];
        [pDataPicker release];
        
        [pView addSubview:pDataSelectorView];
    }
}

-(void)dealloc
{
    //[pDataPicker release];
    [super dealloc];
}

-(void)datePickerChange:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    NSLog(@"选择的日期是  ====== %@",_date);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (pDataSelectorView)
    {
        [pDataSelectorView removeFromSuperview];
        pDataSelectorView = nil;
    }
    
    [self removeFromSuperview];
}

+(void)changeDatePicker:(UIDatePicker*)pDateSender
{
    UIView *v = [[pDateSender subviews] objectAtIndex:0];
    
    int num = [[pDateSender subviews] count];
    int num1 = [[v subviews] count];
    
    //改变最外层的背景
    UIView *v0 = [[v subviews] objectAtIndex:0 ];
    v0.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"redbg.png"]];

    v0.alpha = 0.8;
    //去掉最大的框
    UIView *v20 = [[v subviews] objectAtIndex:(num1 -1)];
    v20.alpha = 1.0;
    
}

@end
