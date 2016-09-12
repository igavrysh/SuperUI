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

#pragma mark -
#pragma mark Public Methods

- (void)createDirectoryAtURL:(NSURL *)url error:(NSError **)error {
    if (url.isFileURL) {
        [self createDirectoryAtPath:url.path error:error];
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

- (void)saveData:(NSData *)data atURL:(NSURL *)url error:(NSError **)error {
    if (url.isFileURL) {
        [self saveData:data atPath:url.path error:error];
    }
}

- (void)saveData:(NSData *)data atPath:(NSString *)path error:(NSError **)error {
    [self createDirectoryAtPath:[path stringByDeletingLastPathComponent] error:error];
    
    IDPReturnVoidIfError(*error);
    
    [data writeToFile:path options:NSAtomicWrite error:error];
}

- (BOOL)fileExistsAtURL:(NSURL *)url {
    return url.isFileURL && [self fileExistsAtPath:url.path];
}

- (void)removeFileAtURL:(NSURL *)url {
    if ([self fileExistsAtURL:url]) {
        [self removeFileAtURL:url];
    }
}

@end
