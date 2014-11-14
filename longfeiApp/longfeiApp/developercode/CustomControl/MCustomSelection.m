//
//  MCustomSelection.m
//  iosNewNavi
//
//  Created by gaoying on 13-9-18.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import "MCustomSelection.h"
#import "MBResource.h"
#import "IconButton.h"
@implementation MCustomSelection
#define Selection_width 55.0
#define Selection_BaseTag 200
- (id)initWithFrame:(CGRect)frame
{
    CGRect _frame = frame;
    _frame.size.height = 28.0f;
    self = [super initWithFrame:_frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[[[MBResource sharedResoure] universalImageForName:@"custom/on_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)]];
        [self addSubview:_backgroundImageView];
        _selectIndex = -1;
        // Initialization code
    }
    return self;
}
-(id)initWithWidth:(CGFloat)width
{
    CGRect _frame =  CGRectMake(0, 0, width, 28.0f);
    self = [self initWithFrame:_frame];
    return self;
}

-(void)dealloc
{
    [_backgroundImageView release];
    [super dealloc];
}
-(void)btnSelectAct:(id)sender
{
    IconButton *btn = (IconButton *)sender;
    btn.selected = YES;
    if(_selectIndex == btn.tag-Selection_BaseTag)
    {
        return;
    }
    _selectIndex = btn.tag-Selection_BaseTag;
    for(int i = 0;i<_numberOfSelections;i++)
    {
        if(_selectIndex == i)
            continue;
        IconButton *btn = (IconButton *)[self viewWithTag:i+Selection_BaseTag];
        btn.selected = NO;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
-(void)setSelectIndex:(int)selectIndex
{
    _selectIndex = selectIndex;
    IconButton *btn = (IconButton *)[self viewWithTag:_selectIndex+Selection_BaseTag];
    btn.selected = YES;

    for(int i = 0;i<_numberOfSelections;i++)
    {
        if(_selectIndex == i)
            continue;
        IconButton *btn = (IconButton *)[self viewWithTag:i+Selection_BaseTag];
        btn.selected = NO;
    }
}
-(void)setNumberOfSelections:(int)numberOfSelections
{
    _numberOfSelections = numberOfSelections;
    if(_numberOfSelections != 0)
        _selection_width = self.frame.size.width/_numberOfSelections;
    if(_selection_width == 0)
        _selection_width = Selection_width;
    CGRect frame = self.frame;
    frame.size.width = _selection_width * _numberOfSelections;
    self.frame = frame;
    _backgroundImageView.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)selectionsWithTitle:(NSArray *)titles
{
    if(titles)
    {
        self.numberOfSelections = [titles count];
        for(NSString *title in titles)
        {
            IconButton *btn = [[IconButton alloc] initWithFrame:CGRectZero style:IconButtonStyleIconCenter];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = Selection_BaseTag+[titles indexOfObject:title];
            btn.frame = CGRectMake(_selection_width*[titles indexOfObject:title], 0,_selection_width,self.frame.size.height);
            [btn setImage:[[MBResource sharedResoure] universalImageForName:@"custom/light_ico_n.png"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0x3d/255.0 green:0x3d/255.0 blue:0x3d/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btn setImage:[[MBResource sharedResoure] universalImageForName:@"custom/light_ico.png"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithRed:0x3d/255.0 green:0xca/255.0 blue:0xb5/255.0 alpha:1.0] forState:UIControlStateSelected];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(btnSelectAct:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = ([titles indexOfObject:title] == _selectIndex);
            btn.imageEdgeOffsets = UIEdgeOffsetsMake(5, 0, 0, 0);
            [self addSubview:btn];
            [btn release];
        }
    }
}
@end
