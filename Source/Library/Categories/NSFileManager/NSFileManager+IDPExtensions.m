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
#import "IDPErrorMacros.h"

static NSString * const kIDPApplicationCacheDirectoryName = @"ApplicationCache";
static NSString * const IDPImagesCacheFolder = @"images";


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
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
}

+ (NSString *)cachesPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSCachesDirectory];
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
}

+ (NSString *)documentPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSDocumentDirectory];
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
}

+ (NSString *)applicationPath {
    IDPFactoryBlock pathFactory = [self pathFactoryWithType:NSApplicationDirectory];
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
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
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
}

+ (NSString *)imagesCachePath {
    IDPFactoryBlock pathFactory = ^{
        NSString *cachePath = [NSFileManager cachesPath];
        
        return [cachePath stringByAppendingPathComponent:IDPImagesCacheFolder];
    };
    
    IDPReturnAfterSettingVariableWithBlockOnce(pathFactory);
}

#pragma mark -
#pragma mark Public Methods

- (void)createDirectoryAtURL:(NSURL *)url error:(NSError **)error {
    if (url.isFileURL) {
        [self createDirectoryAtPath:url.path error:error];
    } else {
        *error = [NSError errorWithDomain:@"URL is not file URL" code:0 userInfo:nil];
    }
}

- (void)createDirectoryAtPath:(NSString *)path error:(NSError **)error {
    if (![self fileExistsAtPath:path]) {
        [self createDirectoryAtPath:path
        withIntermediateDirectories:YES
                         attributes:nil
                              error:error];
    }
}

- (BOOL)fileExistsAtURL:(NSURL *)url {
    return url.isFileURL && [self fileExistsAtPath:url.path];
}

- (void)removeFileAtURL:(NSURL *)url error:(NSError **)error {
    if ([self fileExistsAtURL:url]) {
        NSError *error = nil;
        
        [self removeItemAtURL:url error:&error];
    }
}

- (void)copyItemWithDirectoryCreationAtURL:(NSURL *)url
                                     toURL:(NSURL *)toURL
                                     error:(NSError **)error
{
    [self createDirectoryAtURL:[toURL URLByDeletingLastPathComponent]
                         error:error];
    
    if (*error) {
        return;
    }
    
    [self copyItemAtURL:url toURL:toURL error:error];
}

@end
