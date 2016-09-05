//
//  NSFileManager+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/5/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

static NSString * const kIDPApplicationCacheDirectoryName = @"ApplicationCache";

@implementation NSFileManager (IDPExtensions)

+ (NSString *)libraryUserDomainPath {
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    return [directories firstObject];
}

#pragma mark -
#pragma mark Class Methods

+ (NSString *)applicaitonCachePath {
    static NSString *path = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *domainPath = [NSFileManager libraryUserDomainPath];
        
        path = [domainPath stringByAppendingPathComponent:kIDPApplicationCacheDirectoryName];
        
        NSFileManager *fileManager = [self defaultManager];
        
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:path
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
    });
    
    return path;
}

@end
