//
//  IDPArrayChangeModel.m
//  SuperUI
//
//  Created by Ievgen on 8/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayChangeModel.h"

#import "IDPArrayInsertChangeModel.h"
#import "IDPArrayMoveChangeModel.h"
#import "IDPArrayRemoveChangeModel.h"
#import "IDPArrayReplaceChangeModel.h"

@implementation IDPArrayChangeModel

#pragma mark -
#pragma mark Public Methods

+ (id)insertModelWithArrayModel:(IDPArrayModel *)arrayModel
                          index:(NSUInteger)index
{
    return [IDPArrayInsertChangeModel modelWithArrayModel:arrayModel
                                                    index:index];
}

+ (id)removeModelWithArrayModel:(IDPArrayModel *)arrayModel
                          index:(NSUInteger)index
{
    return [IDPArrayRemoveChangeModel modelWithArrayModel:arrayModel
                                                    index:index];
}

+ (id)replaceModelWithArrayModel:(IDPArrayModel *)arrayModel
                           index:(NSUInteger)index
{
    return [IDPArrayReplaceChangeModel modelWithArrayModel:arrayModel
                                                     index:index];
}

+ (id)moveModelWithArrayModel:(IDPArrayModel *)arrayModel
                      toIndex:(NSUInteger)index
                    fromIndex:(NSUInteger)fromIndex
{
    return [IDPArrayMoveChangeModel modelWithArrayModel:arrayModel
                                                toIndex:index
                                              fromIndex:fromIndex];
}


@end
