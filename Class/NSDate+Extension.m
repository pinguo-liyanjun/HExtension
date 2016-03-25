//
//  NSDate+Extension.m
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)dateWithString:(NSString *)dateStr style:(NSDateDescStyle)style
{
    if(dateStr)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSString *format = nil;
        switch (style) {
            case NSDateDescStyle_yyyyMMdd:
                format = @"yyyy-MM-dd";
                break;
            case NSDateDescStyle_yyyyMMddHHmmss:
                format = @"yyyy-MM-dd HH:mm:ss";
                break;
            case NSDateDescStyle_yyyyMMddhhmmss:
                format = @"yyyy-MM-dd hh:mm:ss";
                break;
            default:
                format = @"yyyy-MM-dd HH:mm:ss";
                break;
        }
        [dateFormatter setDateFormat:format];
        [dateFormatter setLocale:[NSLocale systemLocale]];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        return date;
    }
    else
        return nil;
}

@end
