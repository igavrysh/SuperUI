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

const NSUInteger kIDPArrayModelSampleSize = 30;

@interface IDPUserArrayModel ()

- (void)fillModel;

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
#pragma mark Public Methods

- (void)load {
    @synchronized(self) {
        if (IDPArrayModelLoaded == self.state) {
            [self notifyOfStateChange:IDPArrayModelLoaded];
            return;
        }
        
        if (IDPArrayModelLoading == self.state) {
            return;
        }
        
        self.state = IDPArrayModelLoading;
    }
    
    IDPAsyncPerformInBackgroundQueue(^{
        [self fillModel];
        
        self.state = IDPArrayModelLoaded;
    });
}

#pragma mark -
#pragma mark Private Methods

- (void)fillModel {
    [self performBlockWithoutNotification:^{
        for (NSUInteger i = 0; i < kIDPArrayModelSampleSize; i++) {
            [self insertObject:[IDPUser user] atIndex:0];
        }
    }];
}

@end
