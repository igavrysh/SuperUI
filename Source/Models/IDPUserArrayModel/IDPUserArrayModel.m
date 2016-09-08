//
//  IDPArrayRandomModel.m
//  SuperUI
//
//  Created by Ievgen on 8/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUserArrayModel.h"

#import "IDPUser.h"
#import "IDPGCDQueue.h"
#import "IDPObservableObject.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSNotificationCenter+IDPExtensions.h"
#import "NSFileManager+IDPExtensions.h"

@interface IDPUserArrayModel ()

@end

@implementation IDPUserArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    
    [NSNotificationCenter addObserver:self
                             selector:@selector(save)
                                names:@[UIApplicationWillTerminateNotification,
                                        UIApplicationDidEnterBackgroundNotification]];
    
    return self;
}

#pragma mark - Public Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.objects
                                toFile:[self cachePath]];
}

- (void)performLoading {
    //[NSThread sleepForTimeInterval:3.0f];
    
    NSArray *users = [NSMutableArray new];
    if ([self cacheExists]) {
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:[self cachePath]];
    } else {
        users = [IDPUser usersWithCount:kIDPArrayModelSampleSize];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjects:users];
    }];
    
    self.state = IDPModelDidLoad;
}

- (NSString *)modelPlistName {
    return [NSString stringWithFormat:@"%@.plist", NSStringFromClass([self class])];
}

- (NSString *)cachePath {
    return [[NSFileManager applicationCachePath] stringByAppendingString:[self modelPlistName]];
}

- (BOOL)cacheExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self cachePath]];
}

@end
