//
//  UIApplication+Extension.m
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "UIApplication+Extension.h"

@implementation UIApplication (Extension)

- (UIWindow *)getKeyWindow
{
    return self.windows[0];
}

- (UIViewController *)rootViewController
{
    return [self getKeyWindow].rootViewController;
}

@end
