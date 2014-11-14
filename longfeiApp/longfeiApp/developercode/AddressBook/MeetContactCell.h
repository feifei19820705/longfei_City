//
//  MeetContactCell.h
//  navidog4x
//
//  Created by feifei on 13-2-28.
//
//

#import <UIKit/UIKit.h>

@protocol MeetViewControlsDelegate <NSObject>

-(void)MeetCellButtonAction:(int)ShowCount;

@end

@interface MeetContactCell : UITableViewCell
{
    BOOL bisSelect;        //是否选择了该选项
    id<MeetViewControlsDelegate> pMeetViewControlsDelegate;
}

@property(nonatomic,assign) IBOutlet UIImageView* pSelectImageView;  //是否选择了该选项的ImageView
@property(nonatomic,assign) IBOutlet UIImageView* pIconImageView;    //联系人头像
@property(nonatomic,assign) IBOutlet UILabel*  pContactNameLabel;    //联系人名称
@property(nonatomic,assign) id<MeetViewControlsDelegate> pMeetViewControlsDelegate;  //代理对象
@property(nonatomic,assign) BOOL bisSelect;                          //是否选择了该选项
@property(nonatomic,assign) IBOutlet UILabel*  pContactPhoneLabel;    //联系人名称

-(void)SelectCellAction:(BOOL)bSelectCell;    //选择了cell后显示的状态
-(void)SetSelectImageView:(BOOL)bSelectCell;  //判断是否选中后ImageView的设置

@end
