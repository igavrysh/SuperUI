//
//  NSFileManager+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/5/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

#import "IDPDispatchMacros.h"
#import "IDPBlockTypes.h"

static NSString * const kIDPApplicationCacheDirectoryName = @"ApplicationCache";

@implementation NSFileManager (IDPExtensions)

+ (NSString *)library {
    IDPFactoryBlock pathFactory = ^id(void) {
        NSArray *directories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                   NSUserDomainMask,
                                                                   YES);
        return [directories firstObject];
    };

    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}

#pragma mark -
#pragma mark Class Methods

+ (NSString *)applicationCachePath {
    IDPFactoryBlock pathFactory = ^id(void) {
        NSString *domainPath = [NSFileManager library];
        
        NSString *path = [domainPath stringByAppendingPathComponent:kIDPApplicationCacheDirectoryName];
        
        NSFileManager *fileManager = [self defaultManager];
        
        if (![fileManager fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:path
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
        
        return path;
    };
    
    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}

@end
