//
//  NSBundle+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (IDPExtensions)

+ (NSString *)path;

+ (NSString *)pathForFile:(NSString *)fileName;

+ (id)objectWithClass:(Class)cls;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;

- (NSString *)bundlePath;

- (NSString *)pathForFile:(NSString *)fileName;

- (id)objectWithClass:(Class)cls;

- (id)objectWithClass:(Class)cls
                owner:(id)owner;

- (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;


@end
