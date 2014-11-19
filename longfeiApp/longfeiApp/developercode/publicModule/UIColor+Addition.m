//
//  UIColor+Addition.m
//  Pirelli
//
//  Created by Marco Colombo on 27/09/11.
//  Copyright 2011 Marco Natale Colombo. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)
+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
    
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *hexString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	
    unsigned hexNum;
	if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
	return [UIColor colorWithRGBHex:hexNum];
}

@end
