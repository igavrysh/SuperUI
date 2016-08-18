//
//  IDPArrayRandomModel.m
//  SuperUI
//
//  Created by Ievgen on 8/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayRandomModel.h"

#import "IDPUser.h"

const NSUInteger kIDPArrayModelSampleSize = 100;

@implementation IDPArrayRandomModel

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)randomModel {
    return [[self alloc] init];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    [self fillModel];
    
    return self;
}


#pragma mark -
#pragma mark Private Methods

- (void)fillModel {
    for (NSUInteger i = 0; i < kIDPArrayModelSampleSize; i++) {
        [self addObject:[IDPUser user]];
    }
}


@end
