//
//  UIColor+Addition.h
//  Pirelli
//
//  Created by Marco Colombo on 27/09/11.
//  Copyright 2011 Marco Natale Colombo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
