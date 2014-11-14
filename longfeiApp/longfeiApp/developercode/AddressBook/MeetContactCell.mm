//
//  MeetContactCell.m
//  navidog4x
//
//  Created by feifei on 13-2-28.
//
//

#import "MeetContactCell.h"

@interface MeetContactCell ()

@end

@implementation MeetContactCell

@synthesize pIconImageView;
@synthesize pContactNameLabel;
@synthesize pMeetViewControlsDelegate;
@synthesize bisSelect;
@synthesize pSelectImageView;
@synthesize pContactPhoneLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        bisSelect = NO;     //表示没有选择
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void)dealloc
{
    [super dealloc];
}

-(void)SelectCellAction:(BOOL)bSelectCell
{
    bisSelect = YES;
    if (bisSelect)
    {
        [pSelectImageView setImage:[UIImage imageNamed:@"meeting_button_choose_down.png"]];
       
    }
    else
    {
        [pSelectImageView setImage:[UIImage imageNamed:@"meeting_button_choose_up.png"]];
        
    }
  
}

-(void)SetSelectImageView:(BOOL)bSelectCell
{
    bSelectCell = YES;
    if (bSelectCell)
    {
        [pSelectImageView setImage:[UIImage imageNamed:@"meeting_button_choose_down.png"]];
    }
    else
    {
        [pSelectImageView setImage:[UIImage imageNamed:@"meeting_button_choose_up.png"]];
    }

}

@end
