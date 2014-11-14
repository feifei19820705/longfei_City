//
//  AlertView.m
//  iosPadNavi
//
//  Created by delon on 13-7-2.
//  Copyright (c) 2013年 delon. All rights reserved.
//

#import "CustomAlertView.h"
@interface CustomAlertView (Private) < UIAlertViewDelegate >

@end

@implementation CustomAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if(self)
    {
        
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.alertBlock(alertView, buttonIndex);
}

- (void)dealloc
{
    self.alertBlock = nil;
    
    [super dealloc];
}
@end
