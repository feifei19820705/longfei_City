//
//  AddressBook_Meet_ViewController.m
//  navidog4x
//
//  Created by feifei on 13-4-3.
//
//

#import "AddressBook_Meet_ViewController.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#import "Common.h"
#import "MeetContactCell.h"

@interface AddressBook_Meet_ViewController ()

-(void) initUI;
@end

@implementation AddressBook_Meet_ViewController

@synthesize pAddressBookTableView,pSearchBar;
@synthesize pUISearchDisplayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self)
    {
        sectionDic = [[NSMutableDictionary alloc] init];
        filteredArray = [[NSMutableArray alloc] init];
        pSectionFirstLetterArray = nil;
        resultArray = [[NSMutableArray alloc] init];
        pRecordGetNumberArray = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void) initUI{
    
    UIImage* btn2U = [UIImage imageNamed:@"common_button_2word_up"];
    UIImage* btn2D = [UIImage imageNamed:@"common_button_2word_down"];
    [_sureBtn setBackgroundImage:btn2U forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:btn2D forState:UIControlStateHighlighted];
    
    
    _titlebarImgView.image = [UIImage imageNamed:@"common_titlebar.png"];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"common_button_back_up"] forState:UIControlStateNormal];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"common_button_back_down"] forState:UIControlStateHighlighted];
    _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    
    float blw = _backBtn.currentBackgroundImage.size.width;
    float blh = _backBtn.currentBackgroundImage.size.height;
    float blx = 5.0;
    float bly = (44 - blh)/2;
    _backBtn.frame = CGRectMake(blx, bly, blw, blh);
    
    float brw = _sureBtn.currentBackgroundImage.size.width;
    float brh = _sureBtn.currentBackgroundImage.size.height;
    float brx = self.view.frame.size.width - brw - 5.0;
    float bry = (44 - brh)/2;
    _sureBtn.frame = CGRectMake(brx, bry, brw, brh);
    
    pAddressBookTableView.frame = CGRectMake(0, _titlebarImgView.frame.size.height + StateBar_H, UIScreen_W, UIScreen_H - _titlebarImgView.frame.size.height - StateBar_H);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];

    
    AppDelegate* pApp = [UIApplication sharedApplication].delegate;
    NSString* pAddressBookDataStr = pApp._pSaveDataString;
    pAddressBookListArray = [[NSMutableArray alloc] initWithArray:[pAddressBookDataStr objectFromJSONString]]; // mutableObjectFromJSONString];
    
    [self loadContacts];
    
    pSearchBar.backgroundColor=[UIColor clearColor];
    
    if (IOS_Greater_Or_Equal(__IOS_7_0))
    {
        [pSearchBar setBarStyle:UIBarStyleDefault];
        
        [pSearchBar setBarTintColor:[UIColor clearColor]];
        [pSearchBar setBackgroundImage:[UIImage imageNamed:@""]
                        forBarPosition:UIBarPositionAny
                            barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[pSearchBar.subviews objectAtIndex:0] setHidden:YES];
        [[pSearchBar.subviews objectAtIndex:0] removeFromSuperview];
        for (UIView *subview in pSearchBar.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [subview removeFromSuperview];
                break;
            }
        }
        
        UITextField *searchField = nil;
        
        NSUInteger numViews = [pSearchBar.subviews count];
        for(int i = 0; i < numViews; i++)
        {
            if([[pSearchBar.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
            {
                searchField = [pSearchBar.subviews objectAtIndex:i];
            }
        }
        if( searchField != nil )
        {
            [searchField setBorderStyle:UITextBorderStyleRoundedRect];
        }
    }
}


-(void)dealloc
{
    if (pRecordGetNumberArray && [pRecordGetNumberArray count] > 0)
        [pRecordGetNumberArray removeAllObjects];
    SAFE_RELEASE(pRecordGetNumberArray);
    
    if (pAddressBookListArray && [pAddressBookListArray count] > 0)
        [pAddressBookListArray removeAllObjects];
    SAFE_RELEASE(pAddressBookListArray);
    
    if (resultArray && [resultArray count] > 0)
        [resultArray removeAllObjects];
    SAFE_RELEASE(resultArray);
    
    if (filteredArray && [filteredArray count] > 0)
        [filteredArray removeAllObjects];
    SAFE_RELEASE(filteredArray);
    
    if (sectionDic && [sectionDic count] > 0)
        [sectionDic removeAllObjects];
    SAFE_RELEASE(sectionDic);
    
    SAFE_RELEASE(pRecordSearchStr);

    if (pSectionFirstLetterArray && [pSectionFirstLetterArray count] > 0)
        [pSectionFirstLetterArray removeAllObjects];
    SAFE_RELEASE(pSectionFirstLetterArray);

    pUISearchDisplayController.delegate = nil;
    [pUISearchDisplayController release];
    pUISearchDisplayController = nil;
    
    [_titlebarImgView release];
    [_backBtn release];
    [_sureBtn release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)loadContacts       //加载通讯录
{
    if ([sectionDic count] > 0)
        [sectionDic removeAllObjects];
    if ([resultArray count] > 0)
        [resultArray removeAllObjects];
    
    NSString *sectionName;
    for (int i = 0; i < [pAddressBookListArray count]; i++)
    {
        NSMutableDictionary* pDictionary = [pAddressBookListArray objectAtIndex:i];
        NSString* pNameStr = [pDictionary objectForKey:@"name"];
        NSString* pDicKey = [self SearchGetFirstLetter:pNameStr];
        [sectionDic setObject:[NSMutableArray array] forKey:pDicKey];
    }

    int nSectionNum = 0;
    for (int i = 0; i < [pAddressBookListArray count]; i++)
    {
        sectionName = [self SearchGetFirstLetter:[[pAddressBookListArray objectAtIndex:i] objectForKey:@"name"]];
        
        // 添加tableview中的每段标题字母到数组中
        if ([resultArray count] == 0)
        {
            [resultArray addObject:sectionName];
            nSectionNum = 1;
            NSString* pSectionNum = [NSString stringWithFormat:@"%d",nSectionNum];
            [pRecordGetNumberArray addObject:pSectionNum];
        }
        else
        {
            int nCount = 0;
            int nRecord = 0;
            for (int i = 0; i < [resultArray count]; i++)
            {
                if(![sectionName isEqual:[resultArray objectAtIndex:i]])
                {
                    nRecord++;
                    nCount++;
                    continue;
                }
                else
                {
                    nRecord = 0;
                    break;
                }
            }
            if (nRecord > 0)   // 表示没有从数组中找到匹配的
            {
                // 首先存储首字母到一个数组中，然后存储联系人的首字母的个数到另一个数组中
                [resultArray addObject:sectionName];
                NSString* pSectionNum = [NSString stringWithFormat:@"%d",1];
                [pRecordGetNumberArray addObject:pSectionNum];
            }
            else             // 表示找到了
            {
                // 然后存储联系人的首字母的个数到另一个数组中
                NSString* pTempNum = nil;
                if (pRecordGetNumberArray && [pRecordGetNumberArray count] > 0)
                {
                    pTempNum = [pRecordGetNumberArray objectAtIndex:nCount];
                    nSectionNum = [pTempNum integerValue];
                }
                nSectionNum ++;
                NSString* pSectionNum = [NSString stringWithFormat:@"%d",nSectionNum];
                [pRecordGetNumberArray replaceObjectAtIndex:nCount withObject:pSectionNum];
            }

        }
        
        //[[sectionDic objectForKey:sectionName] addObject:[[pAddressBookListArray objectAtIndex:i] objectForKey:@"NAME"]];
        
        NSString* pSecName = [NSString stringWithFormat:@"%@",[[pAddressBookListArray objectAtIndex:i] objectForKey:@"name"]];
        NSString* pUIDStr = [NSString stringWithFormat:@"%@",[[pAddressBookListArray objectAtIndex:i] objectForKey:@"phone"]];
        
        NSMutableDictionary* pTempDic = [NSMutableDictionary dictionary];
        [pTempDic setObject:pSecName forKey:@"SAVE_NAME"];
        [pTempDic setObject:pUIDStr forKey:@"SAVE_PHONE"];
        
        
        [[sectionDic objectForKey:sectionName] addObject:pTempDic];
    }
}

// 返回按钮响应函数
-(IBAction) BackBUttonAction:(id)sender      
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Table View
// 右侧显示的小图标
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.pAddressBookTableView])
    {
        //添加搜索小图标
        //NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        
        NSMutableArray* indices = [NSMutableArray array];
        //如果是27则表示显示26个字母，在此做的是有什么显示什么（即假如有 A、C、D则只显示A、C、D）
        for (int i = 0; i < /*[pSectionFirstLetterArray count]*/ 27; i++)
        {
            [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
        }
        return indices;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
	{
		[self.pAddressBookTableView scrollRectToVisible:self.pSearchBar.frame animated:NO];
		return -1;
	}
    
    NSMutableString* pFirstletterStr = [NSMutableString string];
    for (int i = 0; i < [pSectionFirstLetterArray count]; i++)
    {
        [pFirstletterStr appendString:[pSectionFirstLetterArray objectAtIndex:i]];
    }
    return  [pFirstletterStr rangeOfString:title].location;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //排序
//    pSectionFirstLetterArray = [(NSMutableArray*)[resultArray sortedArrayUsingSelector:@selector(compare:)] copy];
    if ([resultArray count] > 0)
    {
        SAFE_RELEASE(pSectionFirstLetterArray);
        pSectionFirstLetterArray = [[NSMutableArray alloc] initWithArray:[resultArray sortedArrayUsingSelector:@selector(compare:)]];
    }
    /*
    for (int i = 0; i < [pSectionFirstLetterArray count]; i++)
    {
    }*/
    if ([tableView isEqual:self.pAddressBookTableView])
    {
        return [pSectionFirstLetterArray count];//27;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.pAddressBookTableView])
    {
        NSString *key=[NSString stringWithFormat:@"%@",[pSectionFirstLetterArray objectAtIndex:section]];
        for (int i = 0; i < [resultArray count]; i++)
        {
            if ([key isEqualToString:[resultArray objectAtIndex:i]]) {
                return [[pRecordGetNumberArray objectAtIndex:i] intValue];
            }
        }
    }
    return [filteredArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //如果点击了搜索框则不显示分段标题字段
    if ([tableView isEqual:pUISearchDisplayController.searchResultsTableView])
    {
        return nil;
    }
    
    NSString *key = [NSString stringWithFormat:@"%@",[pSectionFirstLetterArray objectAtIndex:section]];
    return key;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MeetContactCell";
    MeetContactCell* cell = (MeetContactCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    if (cell == nil)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MeetContactCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.pMeetViewControlsDelegate = (id)self;
    
    NSMutableString* pName = [NSMutableString string];
    NSString* pNickName = [NSString string];
    NSMutableString* pTempPhone = [NSMutableString string];
    
    if (![tableView isEqual:self.pAddressBookTableView])
    {
        NSMutableDictionary* pDicTionary = [filteredArray objectAtIndex:indexPath.row];
        [pTempPhone appendFormat:@"%@",[pDicTionary objectForKey:@"SAVE_PHONE"]];
        [pName appendFormat:@"%@",[pDicTionary objectForKey:@"SAVE_NAME"]];
        pNickName = [pDicTionary objectForKey:@"SAVE_NAME"];
    }
    else
    {
        NSString *key=[NSString stringWithFormat:@"%@",[pSectionFirstLetterArray objectAtIndex:indexPath.section]];
        NSMutableArray *persons=[sectionDic objectForKey:key];
        
        
        NSMutableDictionary* pDicTionary = [NSMutableDictionary dictionary];
        pDicTionary = [persons objectAtIndex:indexPath.row];
        
        [pTempPhone appendFormat:@"%@",[pDicTionary objectForKey:@"SAVE_PHONE"]];
        [pName appendFormat:@"%@",[pDicTionary objectForKey:@"SAVE_NAME"]];
        pNickName = [pDicTionary objectForKey:@"SAVE_NAME"];

    }

    [cell.pSelectImageView setHidden:YES];
    [cell.pIconImageView setHidden:YES];

    cell.pContactNameLabel.frame = CGRectMake(15, 6, 220, 21);
    cell.pContactNameLabel.text = pName;
    cell.pContactPhoneLabel.frame = CGRectMake(15, 26, 220, 21);
    cell.pContactPhoneLabel.text = pTempPhone;

    
    return cell;
}


// select row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* pName = nil;
    NSString* pTempPhone = nil;
    if (![tableView isEqual:self.pAddressBookTableView])
    {
        NSMutableDictionary* pDicTionary = [filteredArray objectAtIndex:indexPath.row];
        pTempPhone = [pDicTionary objectForKey:@"SAVE_PHONE"];
        pName = [pDicTionary objectForKey:@"SAVE_NAME"];
    }
    else
    {
        NSString *key=[NSString stringWithFormat:@"%@",[pSectionFirstLetterArray objectAtIndex:indexPath.section]];
        NSMutableArray *persons=[sectionDic objectForKey:key];
        
        NSMutableDictionary* pDicTionary = [NSMutableDictionary dictionary];
        pDicTionary = [persons objectAtIndex:indexPath.row];
        
        pTempPhone = [pDicTionary objectForKey:@"SAVE_PHONE"];
        
        pName = [pDicTionary objectForKey:@"SAVE_NAME"];
    }
    /*
     ECMCC,      //中国移动通信-----chinamobile
     ECUCC,      //中国联通通讯-----chinaunicom
     ECTCC,      //中国电信------CHINATELECOM
     EOtherType  //其他
     
     移动     12593     17951
     联通     17911
     电信     11808
     */
    NSMutableString* pPhoneString = [NSMutableString string];
    
    AppDelegate* pAppdelegate = [UIApplication sharedApplication].delegate;
    if (pAppdelegate.nPhoneType == ECMCC)        //中国移动通信-----chinamobile
    {
        pPhoneString = [NSMutableString stringWithFormat:@"tel://12593%@",pTempPhone];
    }
    else if(pAppdelegate.nPhoneType == ECUCC)    //中国联通通讯-----chinaunicom
    {
        pPhoneString = [NSMutableString stringWithFormat:@"tel://17911%@",pTempPhone];
    }
    else if(pAppdelegate.nPhoneType == ECTCC)    //中国电信------CHINATELECOM
    {
        pPhoneString = [NSMutableString stringWithFormat:@"tel://11808%@",pTempPhone];
    }
    else   //其他
    {
        pPhoneString = [NSMutableString stringWithFormat:@"%@",pTempPhone];
    }
    
  
    NSURL *phoneURL = [NSURL URLWithString:pPhoneString];
    [[UIApplication sharedApplication] openURL:phoneURL];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;  // 控制行高
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
//    if (IOS_Greater_Or_Equal(__IOS_7_0))
//    {
//    }
//    else
//    {
        searchBar.showsCancelButton = YES;
        for(id pSearchButton in [searchBar subviews])
        {
            if([pSearchButton isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton *)pSearchButton;
                [btn setTitle:@"确定"  forState:UIControlStateNormal];
            }
        }
//    }
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [pAddressBookTableView reloadData];
}


#pragma mark - UISearchDisplayDelegate

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    if (IOS_Greater_Or_Equal(__IOS_7_0))
    {
        [controller.searchBar setBackgroundImage:[UIImage imageNamed:@"personalcenter_icon_search_background.png"]];
        
        [tableView setFrame:CGRectMake(0, 44 + 20, 320, controller.searchContentsController.view.frame.size.height - 44 - 20)];
    }
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self performSelectorOnMainThread:@selector(searchWithString:) withObject:searchString waitUntilDone:YES];
    
    return YES;
}

-(void)searchWithString:(NSString *)searchString
{
    [filteredArray removeAllObjects];
    if ([searchString length] != 0)
    {
        //搜索对应分类下的数组
        NSString *sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([searchString characterAtIndex:0])] uppercaseString];
        
        NSArray* pKeys = [sectionDic allKeys];
        NSMutableArray *persons = [NSMutableArray array];
        for (int i = 0; i < [pKeys count]; i++)
        {
            NSString* pKeyStr = [pKeys objectAtIndex:i];
            //NSLog(@"pKeyStr ========= %@",pKeyStr);
            if ([sectionName isEqualToString:pKeyStr])
            {
                persons=[sectionDic objectForKey:sectionName];
                break;
            }
        }
        
        //NSArray *array=[Search_Dic objectForKey:sectionName];
        for (int j=0;j<[persons count];j++)
        {
            NSMutableDictionary* pDicTionary = [NSMutableDictionary dictionary];
            pDicTionary = [persons objectAtIndex:j];
            
            
            NSString* pName = [pDicTionary objectForKey:@"SAVE_NAME"];
            NSString* pPhone = [pDicTionary objectForKey:@"SAVE_PHONE"];
            //NSString* pName = [array objectAtIndex:j];
            //NSLog(@"*************   psearchName ====  %@",pName);
            
            if ([self searchResult:pName searchText:searchString] || [self searchResult:pPhone searchText:searchString])
            { //先按输入的内容搜索
                [filteredArray addObject:pDicTionary];
            }
            else
            { //按拼音搜索
                NSString *string = @"";
                NSString *firststring=@"";
                for (int i = 0; i < [pName length]; i++)
                {
                    if([string length] < 1)
                        string = [NSString stringWithFormat:@"%@",
                                  [POAPinyin quickConvert:[pName substringWithRange:NSMakeRange(i,1)]]];
                    else
                        string = [NSString stringWithFormat:@"%@%@",string,
                                  [POAPinyin quickConvert:[pName substringWithRange:NSMakeRange(i,1)]]];
                    if([firststring length] < 1)
                        firststring = [NSString stringWithFormat:@"%c",
                                       pinyinFirstLetter([pName characterAtIndex:i])];
                    else
                    {
                        if ([pName characterAtIndex:i]!=' ')
                        {
                            firststring = [NSString stringWithFormat:@"%@%c",firststring,
                                           pinyinFirstLetter([pName characterAtIndex:i])];
                        }
                    }
                }
                if ([self searchResult:string searchText:searchString]
                    ||[self searchResult:firststring searchText:searchString] || [self searchResult:pPhone searchText:searchString])
                {
                    
                    [filteredArray addObject:pDicTionary];
                }
            }
        }
    }
}


#pragma mark - 辅助函数

-(NSString*)SearchGetFirstLetter:(NSString*)searchStr   //得到搜索后的首字母，searchStr表示搜索前的字符串
{
    NSString* sectionName = nil;
    if([self searchResult:searchStr searchText:@"曾"])
        sectionName = @"Z";
    else if([self searchResult:searchStr searchText:@"解"])
        sectionName = @"X";
    else if([self searchResult:searchStr searchText:@"仇"])
        sectionName = @"Q";
    else if([self searchResult:searchStr searchText:@"朴"])
        sectionName = @"P";
    else if([self searchResult:searchStr searchText:@"查"])
        sectionName = @"Z";
    else if([self searchResult:searchStr searchText:@"能"])
        sectionName = @"N";
    else if([self searchResult:searchStr searchText:@"乐"])
        sectionName = @"Y";
    else if([self searchResult:searchStr searchText:@"单"])
        sectionName = @"S";
    else
    {
        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([searchStr characterAtIndex:0])] uppercaseString];
    }
    return [sectionName retain];
}

-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT
{
	NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch
											   range:NSMakeRange(0, searchT.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}

-(void) meetMessagecallback:(int)event param:(int)param
{
}

- (void)viewDidUnload
{
    [self setTitlebarImgView:nil];
    [self setBackBtn:nil];
    [self setSureBtn:nil];
    [super viewDidUnload];
}

@end
