//
//  MCustomSwitch.m
//  iosNewNavi
//
//  Created by gaoying on 13-9-18.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import "MCustomSwitch.h"
#import "MBResource.h"
@interface MCustomSwitch()
{
    UIImageView *_leftIconView;
    UIImageView *_rightIconView;
    UIImage *_backgroundView;
    UILabel *_titleLabel;
}
@end
@implementation MCustomSwitch

- (id)initWithFrame:(CGRect)frame
{
    CGRect _frame = frame;
    _frame.size.width = 59.0f;
    _frame.size.height = 28.0f;
    self = [super initWithFrame:_frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[[MBResource sharedResoure] universalImageForName:@"custom/on_bg.png"]];
        _rightIconOff = [[[MBResource sharedResoure] universalImageForName:@"custom/off_ico.png"] retain];
        _rightIconOn = [[[MBResource sharedResoure] universalImageForName:@"custom/on_ico.png"]retain];
        _leftIconOn = [[[MBResource sharedResoure] universalImageForName:@"custom/light_ico.png"]retain];
        
        _leftIconView = [[UIImageView alloc] initWithImage:_leftIconOn];
        _rightIconView = [[UIImageView alloc] initWithImage:_rightIconOn];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:0x5e/255.0 green:0x5e/255.0 blue:0x5e/255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.hidden = YES;
        
        [self addSubview:_titleLabel];
        [self addSubview:_leftIconView];
        [self addSubview:_rightIconView];
        self.on = YES;
        _leftIconView.frame = CGRectMake((self.frame.size.height-_leftIconView.image.size.height)/2, (self.frame.size.height-_leftIconView.image.size.height)/2-0.5, _leftIconView.image.size.width, _leftIconView.image.size.height);
        _rightIconView.frame = CGRectMake(self.frame.size.width - _rightIconView.image.size.width, -0.5,_rightIconView.image.size.width, _rightIconView.image.size.width);
        _titleLabel.frame = CGRectMake(10, 0,self.frame.size.width-20, self.frame.size.height);
        [self addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
-(id)initWithBackgroundImage:(UIImage *)backgroundImage
{
    CGRect _frame = CGRectZero;
    _frame.size.width = backgroundImage.size.width;
    _frame.size.height = backgroundImage.size.height;
    self = [super initWithFrame:_frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        _rightIconOff = [[[MBResource sharedResoure] universalImageForName:@"custom/off_ico.png"] retain];
        _rightIconOn = [[[MBResource sharedResoure] universalImageForName:@"custom/on_ico.png"]retain];
        _leftIconOn = [[[MBResource sharedResoure] universalImageForName:@"custom/light_ico.png"]retain];
        
        _leftIconView = [[UIImageView alloc] initWithImage:_leftIconOn];
        _rightIconView = [[UIImageView alloc] initWithImage:_rightIconOn];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:0x5e/255.0 green:0x5e/255.0 blue:0x5e/255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.hidden = YES;
        [self addSubview:_titleLabel];
        [self addSubview:_leftIconView];
        [self addSubview:_rightIconView];
        self.on = YES;
        _leftIconView.frame = CGRectMake((self.frame.size.height-_leftIconView.image.size.height)/2, (self.frame.size.height-_leftIconView.image.size.height)/2-0.5, _leftIconView.image.size.width, _leftIconView.image.size.height);
        _rightIconView.frame = CGRectMake(self.frame.size.width - _rightIconView.image.size.width, -0.5,_rightIconView.image.size.width, _rightIconView.image.size.width);
        _titleLabel.frame = CGRectMake(10, 0,self.frame.size.width-20, self.frame.size.height);
        [self addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
-(void)setLeftIconOn:(UIImage *)leftIconOn
{
    if(leftIconOn != _leftIconOn)
    {
        [_leftIconOn release];
        _leftIconOn = [leftIconOn retain];
        _leftIconView.frame = CGRectMake((self.frame.size.height-_leftIconOn.size.height)/2, (self.frame.size.height-_leftIconOn.size.height)/2-0.5, _leftIconOn.size.width, _leftIconOn.size.height);
        _leftIconView.image = _leftIconOn;
    }
}
-(void)setRightIconOn:(UIImage *)rightIconOn
{
    if(rightIconOn != _rightIconOn)
    {
        [_rightIconOn release];
        _rightIconOn = [rightIconOn retain];
        _rightIconView.frame = CGRectMake(self.frame.size.width - _rightIconOn.size.width, -0.5,_rightIconOn.size.width, _rightIconOn.size.width);
        _rightIconView.image = _rightIconOn;
    }
}
-(void)setLeftTitleOn:(NSString *)leftTitleOn
{
    if(leftTitleOn != _leftTitleOn)
    {
        [_leftTitleOn release];
        _leftTitleOn = [leftTitleOn retain];
        _titleLabel.text = _leftTitleOn;
        _titleLabel.hidden = NO;
        _leftIconView.hidden = YES;
    }
}
-(void)aaa
{
    [self setOn:!_on animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
- (void)setOn:(BOOL)on
{
    if(_on != on)
    {
        _on = on;
        if(_on)
        {
            _leftIconView.alpha = 1.0;
            _rightIconView.image = _rightIconOn;
            _rightIconView.frame = CGRectMake(self.frame.size.width - _rightIconView.image.size.width, -0.5,_rightIconView.image.size.width, _rightIconView.image.size.width);
            _titleLabel.text = _leftTitleOn;
            _titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        else
        {
            _leftIconView.alpha = 0.0;
            _rightIconView.image = _rightIconOff;
            _rightIconView.frame = CGRectMake(0, -0.5,_rightIconView.image.size.width, _rightIconView.image.size.width);
            _titleLabel.text = _leftTitleOff;
            _titleLabel.textAlignment = NSTextAlignmentRight;
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    if(animated)
    {
        [UIView beginAnimations:@"change" context:NULL];
        [UIView setAnimationDuration:0.3];
        [self setOn:on];
        [UIView commitAnimations];
        return;
    }
    [self setOn:on];
}
-(void)dealloc
{
    [_rightIconOn release];
    [_rightIconOff release];
    [_leftIconOff release];
    [_leftIconOn release];
    [_titleLabel release];
    [_leftIconView release];
    [_rightIconView release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
