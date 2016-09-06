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
#import "NSFileManager+IDPExtensions.h"
#import "NSNotificationCenter+IDPExtensions.h"

const NSUInteger kIDPArrayModelSampleSize = 5;

@interface IDPUserArrayModel ()

@end

@implementation IDPUserArrayModel

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)userArrayModel {
    return [[self alloc] init];
}

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
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    
    [NSNotificationCenter addObserver:self
                             selector:@selector(save)
                                names:@[kIDPApplicationWillTerminate, kIDPApplicationDidEnterBackground]];
    
    return self;
}

#pragma mark - Public Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.objects
                                toFile:[[self class] cachePath]];
}

#pragma mark -
#pragma mark Private Methods

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
