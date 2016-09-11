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

@end
