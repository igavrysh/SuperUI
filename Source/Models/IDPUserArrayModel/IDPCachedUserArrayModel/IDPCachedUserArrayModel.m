//
//  IDPCachedUserArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 9/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCachedUserArrayModel.h"

#import "IDPUser.h"

#import "NSFileManager+IDPExtensions.h"

@implementation IDPCachedUserArrayModel

#pragma mark -
#pragma mark Class Methods

+ (NSString *)modelPlistName {
    return [NSString stringWithFormat:@"%@.plist", NSStringFromClass([self class])];
}

+ (NSString *)cachePath {
    return [[NSFileManager applicationCachePath] stringByAppendingString:[self modelPlistName]];
}

+ (BOOL)cacheExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self cachePath]];
}

#pragma mark -
#pragma mark Public Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.objects
                                toFile:[[self class] cachePath]];
}

- (void)performLoading {
    //[NSThread sleepForTimeInterval:3.0f];
    
    NSArray *users = [NSMutableArray new];
    if ([[self class] cacheExists]) {
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] cachePath]];
    } else {
        users = [IDPUser usersWithCount:kIDPArrayModelSampleSize];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjects:users];
    }];
    
    self.state = IDPModelDidLoad;
}

@end
