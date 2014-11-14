//
//  CustomToolBar.m
//  ButtonDemo
//
//  Created by delon on 13-5-31.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import "CustomToolBar.h"

@implementation CustomToolBar
{
    CustomToolBarLayout _toolBarLayout;
    ItemVerticalAlign _itemVerticalAlign;
    CGSize _minSize;
    BOOL _autosizing;
}
@synthesize toolBarLayout = _toolBarLayout;
@synthesize autosizing = _autosizing;
@synthesize itemViews = _itemViews;

- (void)setToolBarLayout:(CustomToolBarLayout)toolBarLayout
{
    _toolBarLayout = toolBarLayout;
    [self setNeedsLayout];
    [self reloadData];
}

- (void)setAutosizing:(BOOL)autosizing
{
    _autosizing = autosizing;
    [self setNeedsLayout];
}

- (void)setItemVerticalAlign:(ItemVerticalAlign)itemVerticalAlign
{
    _itemVerticalAlign = itemVerticalAlign;
    [self setNeedsLayout];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self->_itemViews = [[NSMutableArray alloc] initWithCapacity:64];
        self->_splitViews = [[NSMutableArray alloc] initWithCapacity:64];
        self->_autosizing = YES;
        self->_itemVerticalAlign = ItemVerticalAlign_bottom;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)dealloc
{
    [_itemViews release];
    [_splitViews release];
    
    [super dealloc];
}

- (void)reloadData
{
    for (UIView *view in _itemViews)
    {
        [view removeFromSuperview];
    }
    [_itemViews removeAllObjects];
    
    for (UIView *view in _splitViews)
    {
        [view removeFromSuperview];
    }
    [_splitViews removeAllObjects];
    
    NSInteger count = [self.dataSource customToolBarItemCount:self];
    for (NSInteger index = 0; index < count; index++)
    {
        UIView *view = [self.dataSource customToolBar:self itemViewAtIndex:index];
        [self addSubview:view];
        [_itemViews addObject:view];
    }
    
    if ([self.dataSource respondsToSelector:@selector(customToolBar:splitViewAtIndex:)])
    {
        for (NSInteger index = 0; index < count - 1; index++)
        {
            UIView *view = [self.dataSource customToolBar:self splitViewAtIndex:index];
            [self addSubview:view];
            [_splitViews addObject:view];
        }
    }

    [self layoutIfNeeded];
}

- (CGFloat)offset:(CGFloat)max withSize:(CGFloat)size
{
    CGFloat offset = 0;
    switch (_itemVerticalAlign)
    {
        case ItemVerticalAlign_bottom:
            offset = max - size;
            break;
        case ItemVerticalAlign_center:
            offset = (max - size) / 2;
            break;
        default:
            break;
    }
    
    return offset - [self bottomOffset];
}

- (CGFloat)offsetAtIndex:(NSInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(customToolBar:offsetAtIndex:)])
    {
        return [self.dataSource customToolBar:self offsetAtIndex:index];
    }
    
    return 0;
}

- (CGFloat)bottomOffset
{
    if ([self.dataSource respondsToSelector:@selector(customToolBarBottomOffset:)])
    {
        return [self.dataSource customToolBarBottomOffset:self];
    }
    
    return 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = [self.dataSource customToolBarItemCount:self];
    
    CGSize size = self.bounds.size;
    if (_autosizing)
    {
        if (_toolBarLayout == CustomToolBarLayout_horizon)
        {
            CGFloat totalItemWidth = size.width;
            for (UIView *view in _splitViews)
            {
                totalItemWidth -= view.bounds.size.width;
            }
            
            CGFloat itemWidth = totalItemWidth / count;
            CGFloat offsetX = 0;
            for (NSInteger index = 0; index < _itemViews.count; index++)
            {
                UIView *itemView = [_itemViews objectAtIndex:index];
                CGSize itemSize = itemView.bounds.size;
                itemView.frame = CGRectMake(offsetX, [self offset:size.height withSize:itemSize.height], itemWidth, itemSize.height);
                offsetX += itemWidth;
                if (index < _splitViews.count)
                {
                    UIView *splitView = [_splitViews objectAtIndex:index];
                    CGSize splitSize = splitView.bounds.size;
                    splitView.frame = CGRectMake(offsetX, [self offset:size.height withSize:splitSize.height], splitSize.width, splitSize.height);
                    offsetX += splitSize.width;
                }
            }
            
        } else if (_toolBarLayout == CustomToolBarLayout_vertical) {
            CGFloat totalItemHeight = size.height;
            for (UIView *view in _splitViews)
            {
                totalItemHeight -= view.bounds.size.height;
            }
            
            CGFloat itemHeight = totalItemHeight / count;
            CGFloat offsetY = 0;
            for (NSInteger index = 0; index < _itemViews.count; index++)
            {
                UIView *itemView = [_itemViews objectAtIndex:index];
                CGSize itemSize = itemView.bounds.size;
                itemView.frame = CGRectMake([self offset:size.width withSize:itemSize.width], offsetY, itemSize.width, itemHeight);
                offsetY += itemHeight;
                if (index < _splitViews.count)
                {
                    UIView *splitView = [_splitViews objectAtIndex:index];
                    CGSize splitSize = splitView.bounds.size;
                    splitView.frame = CGRectMake([self offset:size.width withSize:splitSize.width], offsetY, splitSize.width, splitSize.height);
                    offsetY += splitSize.height;
                }
            }
        }

    } else {
        if (_toolBarLayout == CustomToolBarLayout_horizon)
        {
            CGFloat totalItemWidth = 0;
            for (UIView *view in _splitViews)
            {
                totalItemWidth += view.bounds.size.width;
            }
            
            for (UIView *view in _itemViews)
            {
                totalItemWidth += view.bounds.size.width;
            }
            
            CGFloat offsetX = 0;
            for (NSInteger index = 0; index < _itemViews.count; index++)
            {
                UIView *itemView = [_itemViews objectAtIndex:index];
                CGSize itemSize = itemView.bounds.size;
                offsetX += [self offsetAtIndex:index];
                itemView.frame = CGRectMake(offsetX, [self offset:size.height withSize:itemSize.height], itemSize.width, itemSize.height);
                offsetX += itemSize.width;
                if (index < _splitViews.count)
                {
                    UIView *splitView = [_splitViews objectAtIndex:index];
                    CGSize splitSize = splitView.bounds.size;
                    splitView.frame = CGRectMake(offsetX, [self offset:size.height withSize:splitSize.height], splitSize.width, splitSize.height);
                    offsetX += splitSize.width;
                }
            }
        } else if (_toolBarLayout == CustomToolBarLayout_vertical) {
            CGFloat totalItemHeight = 0;
            for (UIView *view in _splitViews)
            {
                totalItemHeight += view.bounds.size.height;
            }
            
            for (UIView *view in _itemViews)
            {
                totalItemHeight += view.bounds.size.height;
            }

            CGFloat offsetY = 0;
            for (NSInteger index = 0; index < _itemViews.count; index++)
            {
                UIView *itemView = [_itemViews objectAtIndex:index];
                CGSize itemSize = itemView.bounds.size;
                
                offsetY += [self offsetAtIndex:index];
                itemView.frame = CGRectMake([self offset:size.width withSize:itemSize.width], offsetY, itemSize.width, itemSize.height);
                offsetY += itemSize.height;
                if (index < _splitViews.count)
                {
                    UIView *splitView = [_splitViews objectAtIndex:index];
                    CGSize splitSize = splitView.bounds.size;
                    splitView.frame = CGRectMake([self offset:size.width withSize:splitSize.width], offsetY, splitSize.width, splitSize.height);
                    offsetY += splitSize.height;
                }
            }
        }
    }
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize fitSize = CGSizeZero;
    _minSize = (CGSize){ MAXFLOAT,MAXFLOAT };
    if (_toolBarLayout == CustomToolBarLayout_horizon)
    {
        for (UIView *view in _itemViews)
        {
            fitSize.height = MAX(fitSize.height, view.bounds.size.height);
            _minSize.height = MIN(_minSize.height, view.bounds.size.height);
        }
    } else if (_toolBarLayout == CustomToolBarLayout_vertical) {
        for (UIView *view in _itemViews)
        {
            fitSize.width = MAX(fitSize.width, view.bounds.size.width);
            _minSize.width = MIN(_minSize.width, view.bounds.size.width);
        }
    }
    
    return fitSize;
}
-(UIView *)customViewAtIndex:(NSInteger)index
{
    if(_itemViews && [_itemViews count]>index)
        return [_itemViews objectAtIndex:index];
    else
        return nil;
}
@end
