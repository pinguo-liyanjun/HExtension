//
//  UIColor+Extension.m
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithHex:(int)hex alpha:(float)alpha
{
    float r = ((float)((hex & 0xff0000) >> 16))/255.0;
    float g = ((float)((hex & 0xff00) >> 8))/255.0;
    float b = ((float)((hex & 0xff) >> 0))/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hex
{
    return [self colorWithHex:hex alpha:1.0];
}

@end
