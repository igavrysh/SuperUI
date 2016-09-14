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
#import "IDPBlockTypes.h"
#import "IDPBlockMacros.h"
#import "IDPObservableObject.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSNotificationCenter+IDPExtensions.h"
#import "NSFileManager+IDPExtensions.h"

#import "IDPDispatchMacros.h"
#import "IDPBlockTypes.h"

@interface IDPUserArrayModel ()
@property (nonatomic, strong) id    observer;

- (void)startObservingNotificationsForNames:(NSArray *)names
                                  withBlock:(IDPVoidBlock)block;

- (void)startObservingNotificationsForName:(NSString *)name
                                 withBlock:(IDPVoidBlock)block;

- (void)stopObservingNotificationsForNames:(NSArray *)names;

- (void)stopObservingNotificationsForName:(NSString *)name;

- (NSArray *)applicationNotifications;

@end

@implementation IDPUserArrayModel

@dynamic plistName;
@dynamic cacheExists;
@dynamic cachePath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self stopObservingNotificationsForNames:[self applicationNotifications]];
}

- (instancetype)init {
    self = [super init];
    
    [self startObservingNotificationsForNames:[self applicationNotifications]
                                    withBlock:^{
                                        [self save];
                                    }];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)plistName {
    return [NSString stringWithFormat:@"%@.plist", NSStringFromClass([self class])];
}

- (BOOL)isCacheExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.cachePath];
}

- (NSString *)cachePath {
    return [[NSFileManager applicationCachePath] stringByAppendingString:self.plistName];
}

#pragma mark - 
#pragma mark Public Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.objects
                                toFile:self.cachePath];
}


- (void)performLoading {
    //[NSThread sleepForTimeInterval:3.0f];
    
    NSArray *users = [NSMutableArray new];
    if (self.cacheExists) {
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachePath];
    } else {
        users = [IDPUser usersWithCount:kIDPArrayModelSampleSize];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjects:users];
    }];
    
    self.state = IDPModelDidLoad;
}

#pragma mark -
#pragma mark Private Methods

- (void)startObservingNotificationsForNames:(NSArray *)names
                                  withBlock:(IDPVoidBlock)block
{
    [names performBlockWithEachObject:^(NSString *name) {
        [self startObservingNotificationsForName:name withBlock:block];
    }];
}

- (void)startObservingNotificationsForName:(NSString *)name
                                 withBlock:(IDPVoidBlock)block
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    self.observer = [center addObserverForName:name
                                        object:nil
                                         queue:nil
                                    usingBlock:^(NSNotification * _Nonnull note) {
                                        IDPPerformBlock(block);
                                    }];
}

- (void)stopObservingNotificationsForNames:(NSArray *)names {
    [names performBlockWithEachObject:^(NSString *name) {
        [self stopObservingNotificationsForName:name];
    }];
}

- (void)stopObservingNotificationsForName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer name:name object:nil];
}

- (NSArray *)applicationNotifications {
    IDPFactoryBlock block = ^{
        return @[UIApplicationWillTerminateNotification, UIApplicationDidEnterBackgroundNotification];
    };
    
    IDPReturnAfterSettingVariableWithBlockOnce(block);
}

@end
