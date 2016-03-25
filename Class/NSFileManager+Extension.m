//
//  NSFileManager+Extension.m
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import "NSFileManager+Extension.h"

@implementation NSFileManager (Extension)

+ (NSString *)libPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)appPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)resourcePath
{
   return [[NSBundle mainBundle] resourcePath];
}

+ (BOOL) creatFileWithFilePath:(NSString *)filePath
{
    if (filePath == nil && [filePath length] == 0)
    {
        return NO;
    }
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        //不存在文件
        NSError *error = nil;
        return [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        
    }
    
    //已经存在文件了
    return YES;
}

@end
