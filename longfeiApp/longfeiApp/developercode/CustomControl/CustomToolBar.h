//
//  CustomToolBar.h
//  ButtonDemo
//
//  Created by delon on 13-5-31.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum CustomToolBarLayout
{
    CustomToolBarLayout_horizon,
    CustomToolBarLayout_vertical,
} CustomToolBarLayout;

typedef enum ItemVerticalAlign
{
    ItemVerticalAlign_top,
    ItemVerticalAlign_center,
    ItemVerticalAlign_bottom
} ItemVerticalAlign;

@interface CustomToolBar : UIControl
{
@protected
    NSMutableArray *_itemViews;
    NSMutableArray *_splitViews;
}
@property(nonatomic, assign) CustomToolBarLayout toolBarLayout;
@property(nonatomic, readonly) NSArray *itemViews;
@property(nonatomic, readonly) CGSize minSize;
@property(nonatomic, assign) BOOL autosizing;
@property(nonatomic, assign) ItemVerticalAlign itemVerticalAlign;
@property(nonatomic, assign) id dataSource;
- (void)reloadData;
-(UIView *)customViewAtIndex:(NSInteger)index;
@end

@protocol CustomToolBarDataSource
@required
- (NSInteger)customToolBarItemCount:(CustomToolBar *)toolBar;
- (UIView *)customToolBar:(CustomToolBar *)toolBar itemViewAtIndex:(NSInteger)index;
@optional
- (UIView *)customToolBar:(CustomToolBar *)toolBar splitViewAtIndex:(NSInteger)index;
- (CGFloat)customToolBar:(CustomToolBar *)toolBar offsetAtIndex:(NSInteger)index;
- (CGFloat)customToolBarBottomOffset:(CustomToolBar *)toolBar;
@end
