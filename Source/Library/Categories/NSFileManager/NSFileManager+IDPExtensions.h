//
//  NSFileManager+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 9/5/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (IDPExtensions)

+ (NSString *)libraryPath;

+ (NSString *)cachesPath;

+ (NSString *)documentPath;

+ (NSString *)applicationPath;

+ (NSString *)applicationCachePath;

+ (NSString *)imagesCachePath;

- (void)createDirectoryAtURL:(NSURL *)url error:(NSError **)error;
- (void)createDirectoryAtPath:(NSString *)path error:(NSError **)error;

- (BOOL)fileExistsAtURL:(NSURL *)url;

- (void)removeFileAtURL:(NSURL *)url error:(NSError **)error;

- (void)copyItemAtURL:(NSURL *)url toURL:(NSURL *)toURL;

@end
