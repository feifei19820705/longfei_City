//
//  AddressBook_Meet_ViewController.h
//  navidog4x
//
//  Created by feifei on 13-4-3.
//
//

#import <UIKit/UIKit.h>
#import "pinyin.h"
#import "POAPinyin.h"

@interface AddressBook_Meet_ViewController : UIViewController <UISearchDisplayDelegate,UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,UISearchBarDelegate>
{
    NSMutableDictionary*       sectionDic;                     //该字典存储列表数据的键值对
    NSMutableArray*            filteredArray;                  //存储搜索后数据的数组
    NSMutableArray*            pSectionFirstLetterArray;       //存储列表的第一个首字母的数组
    NSMutableArray*            pAddressBookListArray;          //存储好友列表的数组
    NSMutableArray*            resultArray;                    //排序后得到的结果数组
    NSString*                  pSaveFriendStr;                 //存储好友的字符串
    NSString*                  pRecordSearchStr;               //记录搜索的字符串
    NSMutableArray*            pRecordGetNumberArray;          //记录得到的行数
}

@property(nonatomic,assign) IBOutlet UITableView*       pAddressBookTableView;
@property(nonatomic,assign) IBOutlet UISearchBar*       pSearchBar;
@property(nonatomic,retain) IBOutlet UISearchDisplayController* pUISearchDisplayController;    //UISearchDisplayController视图控制器
@property (retain, nonatomic) IBOutlet UIImageView *titlebarImgView;

@property (retain, nonatomic) IBOutlet UIButton *backBtn;
@property (retain, nonatomic) IBOutlet UIButton *sureBtn;

-(IBAction)BackBUttonAction:(id)sender;      //返回按钮响应函数


// 得到搜索后的首字母，searchStr表示搜索前的字符串
-(NSString*)SearchGetFirstLetter:(NSString*)searchStr;

@end
