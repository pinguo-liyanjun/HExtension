//
//  UIImage+Extension.h
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageFromView:(UIView *)theView;

+(UIImage *)imageFromView:(UIView *)theView frame:(CGRect)frame;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;

@end
