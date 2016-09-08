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

+ (instancetype)modelWithArrayModel:(IDPArrayModel *)arrayModel
                            toIndex:(NSUInteger)index
                          fromIndex:(NSUInteger)fromIndex
{
    return [[self alloc] initWithArrayModel:arrayModel
                                    toIndex:index
                                  fromIndex:fromIndex];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel
                           toIndex:(NSUInteger)index
                         fromIndex:(NSUInteger)fromIndex

{
    self = [super initWithArrayModel:arrayModel index:index];
    
    self.fromIndex = fromIndex;
    
    return self;
}

@end
