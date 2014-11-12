//
//  MainViewControllor.m
//  生活小助手
//
//  Created by feifei on 14-2-12.
//  Copyright (c) 2014年 feifei. All rights reserved.
//

#import "MainViewControllor.h"
#import "RegexKitLite.h"
#import "AddressBook_Meet_ViewController.h"
#import "AppDelegate.h"
#import "Common.h"
#import "NAmeview.h"

@interface MainViewControllor ()
{
    NAmeview* pNAmevie;
}

@end

@implementation MainViewControllor

@synthesize accessGranted = _accessGranted;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(instancetype)ShareMainControllorInstance
{
    static MainViewControllor* pMainViewControllor;
    static dispatch_once_t pGcd;
    dispatch_once(&pGcd,^{
        pMainViewControllor = [[self alloc] init];
    });
    return pMainViewControllor;
}

-(void)dealloc
{
    [pNAmevie release];
    [pTabBar release];
    [pShowPhoneTextField release];
    [pPhoneLabel release];
    [pPhoneTypeLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* pBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky@2x.png"]];
    pBgImageView.frame = CGRectMake(0, 0, UIScreen_W, UIScreen_H);
    [self.view addSubview:pBgImageView];
    [pBgImageView release];
    
    [self InitUserPhoneInfo];
    [self ShowUsersPhoneInfo:YES];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
    _accessGranted = NO;
    
    pNAmevie = [[NAmeview alloc] init];
    pNAmevie.frame = CGRectMake(0, 20 ,UIScreen_W, UIScreen_H - 50);
    [self.view addSubview:pNAmevie];
    [pNAmevie setHidden:YES];
    
    
    pTabBar = [[UITabBar alloc] init];
    pTabBar.frame = CGRectMake(0, UIScreen_H - 50, UIScreen_W, 50);
    pTabBar.delegate = (id)self;
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"手机号" image:nil tag:100];
    UITabBarItem * tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:nil tag:101];
    UITabBarItem * tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"密码设置" image:nil tag:102];
    UITabBarItem * tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"自定义二" image:nil tag:103];
    NSArray *tabBarItemArray = [[NSArray alloc] initWithObjects: tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4,nil];
    [pTabBar setItems: tabBarItemArray];
    [tabBarItemArray release];
    pTabBar.barStyle = UIBarStyleBlackOpaque;
    
    
    [self.view addSubview:pTabBar];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)FinishButtonAction:(id)sender
{
    [pShowPhoneTextField resignFirstResponder];
    AppDelegate* pApp = [UIApplication sharedApplication].delegate;
    
    pPhoneLabel.text = [NSString stringWithFormat:@"手机号 ：%@",pShowPhoneTextField.text];
    NSString* pTempString = pShowPhoneTextField.text;
    NSString* MobileMatchStr = @"^1[3,5,8]\\d{9}$";
    if ([pTempString isMatchedByRegex:MobileMatchStr])
    {
        //电信号段
        NSString* CTCCSub = @"^1[3,5,8][3,0,1,9]\\d{8}$";
        NSString* CTCCSub2 = @"^1[3][4][9]\\d{7}$";
        
        /*
         中国电信号段：
         cdma制式 133、153、180、181（今年下半年放号）、189
         全球星 1349
         中国移动号段：
         gsm/tdscdma制式 1340-1348、135、136、137、138、139、147（数据卡）、150、151、152、157、158、159、182、183、187、188
         中国联通号段：
         gsm/wcdma制式 130、131、132、145（数据卡）、155、156、185、186
         联通和移动现在已经没有特定TD专属号段和wcdma专属号段，号码资源稀缺，而且很多地方信号覆盖不如gsm理想，很多号段都是支持gsm和TD混合模式或者GSM和wcdma混合模式
         
         
         中国移动通信-----chinamobile      CMCC
         中国联通通讯-----chinaunicom     CUCC
         中国电信      ------CHINATELECOM   CTCC
         */
        //移动号段
        NSString* CMCCStr = @"^1[3][4][0,1,2,3,4,5,6,7,8]\\d{7}$";
        NSString* CMCCStr2 = @"^1[3][5,6,7,8,9]\\d{8}$";
        NSString* CMCCStr3 = @"^1[5][0,1,2,7,8,9]\\d{8}$";
        NSString* CMCCStr4 = @"^1[8][2,3,7,8]\\d{8}$";
        
        //联通号段
        NSString* CUCCStr = @"^1[3][0,1,2]\\d{8}$";
        NSString* CUCCStr2 = @"^1[5][5,6]\\d{8}$";
        NSString* CUCCStr3 = @"^1[8][5,6]\\d{8}$";
        
        
        
        if ([pTempString isMatchedByRegex:CTCCSub] || [pTempString isMatchedByRegex:CTCCSub2])
        {
            //NSLog(@"---------电信");
            pPhoneTypeLabel.text = @"中国电信";
            pApp.nPhoneType = ECTCC;
            
        }
        else if([pTempString isMatchedByRegex:CMCCStr] ||
                [pTempString isMatchedByRegex:CMCCStr2] ||
                [pTempString isMatchedByRegex:CMCCStr3] ||
                [pTempString isMatchedByRegex:CMCCStr4])
        {
            //NSLog(@"---------移动");
            pPhoneTypeLabel.text = @"中国移动";
            pApp.nPhoneType = ECMCC;

        }
        else if([pTempString isMatchedByRegex:CUCCStr] ||
                [pTempString isMatchedByRegex:CUCCStr2] ||
                [pTempString isMatchedByRegex:CUCCStr3])
        {
            //NSLog(@"---------联通");
            pPhoneTypeLabel.text = @"中国联通";
            pApp.nPhoneType = ECUCC;
            
        }
    }
    else
    {
        //NSLog(@"输入的手机号不正确");
        pPhoneTypeLabel.text = @"";
        pPhoneLabel.text = @"";
        pApp.nPhoneType = EOtherType;
    }
   
    
}

-(void)InitUserPhoneInfo
{
    pShowPhoneTextField = [[UITextField alloc] init];
    pShowPhoneTextField.frame = CGRectMake(10, 50, 300, 50);
    pShowPhoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    pShowPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    pShowPhoneTextField.placeholder = @"请输入您的手机号";
    pShowPhoneTextField.returnKeyType = UIReturnKeyGo;
    pShowPhoneTextField.clearsOnBeginEditing = YES;
    [self.view addSubview:pShowPhoneTextField];
    
    pFinishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pFinishButton.frame = CGRectMake(100, 120, 50, 40);
    [pFinishButton setTitle:@"完成" forState:UIControlStateNormal];
    [pFinishButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [pFinishButton addTarget:self action:@selector(FinishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pFinishButton];
    
    
    pPhoneLabel = [[UILabel alloc] init];
    pPhoneLabel.frame = CGRectMake(10, 180, 300, 40);
    pPhoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:pPhoneLabel];
    
    pPhoneTypeLabel = [[UILabel alloc] init];
    pPhoneTypeLabel.frame = CGRectMake(10, 240, 300, 40);
    pPhoneTypeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:pPhoneTypeLabel];
}


-(void)ShowUsersPhoneInfo:(BOOL)bIsShow   //显示用户使用信息
{
    if (bIsShow == YES)
    {
        [pShowPhoneTextField setHidden:NO];
        [pFinishButton setHidden:NO];
        [pPhoneLabel setHidden:NO];
        [pPhoneTypeLabel setHidden:NO];
    }
    else
    {
        [pShowPhoneTextField setHidden:YES];
        [pFinishButton setHidden:YES];
        [pPhoneLabel setHidden:YES];
        [pPhoneTypeLabel setHidden:YES];
    }

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //NSLog(@"--------- %@",NSStringFromSelector(_cmd));
    [pNAmevie setHidden:YES];
    if (item.tag == 100)
    {
        [self ShowUsersPhoneInfo:YES];
    }
    else if(item.tag == 101)
    {
        [self ShowUsersPhoneInfo:NO];
        AddressBook_Meet_ViewController* pAddressView = [[AddressBook_Meet_ViewController alloc] initWithNibName:@"AddressBook_Meet_ViewController" bundle:nil];
        [self presentViewController:pAddressView animated:YES completion:^{
            
        }];
        [pAddressView release];
    }
    else if (item.tag == 102)
    {
         [pNAmevie setHidden:NO];
    }
    else if (item.tag == 103)
    {
        
    }
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items
{
    //NSLog(@"--------- %@",NSStringFromSelector(_cmd));
}


- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items
{
    //NSLog(@"--------- %@",NSStringFromSelector(_cmd));
}

- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed
{
    //NSLog(@"--------- %@",NSStringFromSelector(_cmd));
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed
{
    NSLog(@"--------- %@",NSStringFromSelector(_cmd));
}

@end
