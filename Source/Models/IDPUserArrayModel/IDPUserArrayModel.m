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

const NSUInteger kIDPArrayModelSampleSize = 5;

@interface IDPUserArrayModel ()

@end

@implementation IDPUserArrayModel

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)userArrayModel {
    return [[self alloc] init];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Private Methods

- (void)performLoading {
    //[NSThread sleepForTimeInterval:3.0f];
    
    NSMutableArray *users = [NSMutableArray new];
    if ([[self class] cacheExists]) {
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] cachePath]];
    } else {
        users = [IDPUser usersWithCount:kIDPArrayModelSampleSize];
    }
    
    [self performBlockWithoutNotification:^{
        [self addObjects:users];
    }];
    
    self.state = IDPLoadableModelDidLoad;
}

@end
