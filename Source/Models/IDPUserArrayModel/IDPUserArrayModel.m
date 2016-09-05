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
    if ([IDPUserArrayModel cacheExists]) {
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] cachePath]];
    } else {
        for (NSUInteger i = 0; i < kIDPArrayModelSampleSize; i++) {
            [users addObject:[IDPUser user]];
        }
    }
    
    [self performBlockWithoutNotification:^{
        for (NSUInteger i = 0; i < users.count; i++) {
            [self insertObject: users[i] atIndex:i];
        }
    }];
    
    self.state = IDPLoadableModelLoaded;
}

@end
