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

@interface NSFileManager(NSFileManagerPrivate)

+ (IDPFactoryBlock)pathFactoryWithType:(NSSearchPathDirectory)type;

@end

@implementation NSFileManager (NSFileManagerPrivate)

+ (IDPFactoryBlock)pathFactoryWithType:(NSSearchPathDirectory)type {
    return ^{
        NSArray *directories = NSSearchPathForDirectoriesInDomains(type,
                                                                   NSUserDomainMask,
                                                                   YES);
        return [directories firstObject];
    };
}

@end

@implementation NSFileManager (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (NSString *)libraryPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSLibraryDirectory];
    
    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}

+ (NSString *)cachesPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSCachesDirectory];
    
    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}

+ (NSString *)documentPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSDocumentDirectory];
    
    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}

+ (NSString *)applicationPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSApplicationDirectory];
    
    IDPSetAndReturnStaticVariableWithBlock(pathFactory);
}


+ (NSString *)applicationCachePath {
    IDPFactoryBlock pathFactory = ^{
        NSString *domainPath = [NSFileManager libraryPath];
        
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
