//
//  IDPArrayOneIndexChangeModel.m
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayOneIndexChangeModel.h"

@interface IDPArrayOneIndexChangeModel ()
@property (nonatomic, assign) NSUInteger index;

@end

@implementation IDPArrayOneIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithIndex:(NSUInteger)index {
    return [[self alloc] initWithIndex:index];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];

    self.index = index;
    
    return self;
}

@end
