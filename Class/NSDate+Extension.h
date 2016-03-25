//
//  NSDate+Extension.h
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NSDateDescStyle)
{
    NSDateDescStyle_yyyyMMdd,
    NSDateDescStyle_yyyyMMddHHmmss,
    NSDateDescStyle_yyyyMMddhhmmss,
    NSDateDescStyle_Other
};

@interface NSDate (Extension)

+ (NSDate *)dateWithString:(NSString *)dateStr style:(NSDateDescStyle)style;

@end
