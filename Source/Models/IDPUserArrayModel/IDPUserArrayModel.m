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
}

- (void)performLoading {
    NSArray *users = [IDPUser usersWithCount:kIDPArrayModelSampleSize];
    
    [self performBlockWithoutNotification:^{
        [self addObjects:users];
    }];
    
    self.state = IDPModelDidLoad;
}

@end
