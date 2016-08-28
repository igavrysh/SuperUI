//
//  IDPArrayTwoIndexChangeModel.m
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayTwoIndexChangeModel.h"

@interface IDPArrayTwoIndexChangeModel ()
@property (nonatomic, assign)   NSUInteger  fromIndex;

@end

@implementation IDPArrayTwoIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithToIndex:(NSUInteger)index
                       fromIndex:(NSUInteger)fromIndex
{
    return [[self alloc] initWithIndex:index];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)initWithToIndex:(NSUInteger)index
                      fromIndex:(NSUInteger)fromIndex
{
    self = [super initWithIndex:index];
    
    self.fromIndex = fromIndex;
    
    return self;
}

@end
