//
//  NSData+Extension.m
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "NSData+Extension.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSData (Extension)

+ (NSString *)toHexString:(NSData *)data
{
    if (data == nil || [data length] == 0)
    {
        return @"";
    }
    
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *hexString = [NSMutableString string];
    for (int i = 0; i < [data length]; i++)
    {
        [hexString appendString:[NSString stringWithFormat:@"%02x",bytes[i]&0xFF]];
    }
    return hexString;
}

- (NSString *)hexSting
{
    return [NSData toHexString:self];
}

- (NSString *)md5String
{
    const char *concat_str = self.bytes;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
}

@end
