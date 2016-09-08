//
//  IDPArrayOneIndexChangeModel.m
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayOneIndexChangeModel.h"

#import "IDPArrayModel.h"

@interface IDPArrayOneIndexChangeModel ()
@property (nonatomic, assign) NSUInteger        index;
@property (nonatomic, strong) IDPArrayModel     *arrayModel;

@end

@implementation IDPArrayOneIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArrayModel:(IDPArrayModel *)arrayModel
                              index:(NSUInteger)index

{
    return [[self alloc] initWithArrayModel:arrayModel
                                      index:index];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel
                             index:(NSUInteger)index

{
    self = [super init];

    self.index = index;
    self.arrayModel = arrayModel;
    
    return self;
}

@end
