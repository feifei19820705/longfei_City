//
//  TestViewController.m
//  longfeiApp
//
//  Created by yangcf on 14-11-19.
//  Copyright (c) 2014年 yangcf. All rights reserved.
//

#import "TestViewController.h"
#import "DataSelectorView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* pbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pbackButton.frame = CGRectMake(10, 50, 50,40);
    [pbackButton setTitle:@"返回" forState:UIControlStateNormal];
    [pbackButton setTitle:@"返回" forState:UIControlStateHighlighted];
    [pbackButton addTarget:self action:@selector(backbuttonpressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pbackButton];
    
    UIButton* pTestDatePickerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pTestDatePickerButton.frame = CGRectMake(20, 90, 150,40);
    [pTestDatePickerButton setTitle:@"日期视图" forState:UIControlStateNormal];
    [pTestDatePickerButton setTitle:@"日期视图" forState:UIControlStateHighlighted];
    [pTestDatePickerButton addTarget:self action:@selector(TestDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pTestDatePickerButton];

}

-(void)TestDatePicker
{
    [DataSelectorView showDataSelector:self.view];
    
//    DataSelectorView* ppp = [[DataSelectorView alloc] initDataSelector];
//    [self.view addSubview:ppp];
}

-(void)backbuttonpressed
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
