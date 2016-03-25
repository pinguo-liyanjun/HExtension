//
//  NSFileManager+Extension.h
//  HExtension
//
//  Created by C360_liyanjun on 16/3/15.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extension)

+ (NSString *)libPath;

+ (NSString *)cachesPath;

+ (NSString *)documentPath;

+ (NSString *)tempPath;

+ (NSString *)appPath;

+ (NSString *)resourcePath;

+ (BOOL) creatFileWithFilePath:(NSString *)filePath;

@end
