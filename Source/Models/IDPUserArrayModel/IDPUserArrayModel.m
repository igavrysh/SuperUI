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

const NSUInteger kIDPArrayModelSampleSize = 10;

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
#pragma mark Public Methods

- (IDPUserArrayModel *)filteredArrayUsingFilterString:(NSString *)filter {
    NSArray *objects = [self.objects filteredArrayUsingBlock:^BOOL(IDPUser *user) {
        return NSNotFound != [user.name rangeOfString:filter
                                              options:NSCaseInsensitiveSearch].location;
    }];
    
    IDPUserArrayModel *model = [[IDPUserArrayModel alloc] initWithObjects:objects];
    [model addObservers:[self.observerSet allObjects]];
    
    return model;
}

#pragma mark -
#pragma mark Private Methods

- (void)performLoading {
    [self performBlockWithoutNotification:^{
        for (NSUInteger i = 0; i < kIDPArrayModelSampleSize; i++) {
            [self insertObject:[IDPUser user] atIndex:0];
        }
    }];
    
    [NSThread sleepForTimeInterval:10.0f];
    
    self.state = IDPLoadableModelLoaded;
}

@end
