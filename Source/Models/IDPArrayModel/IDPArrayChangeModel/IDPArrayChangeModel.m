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

+ (id)insertModelWithIndex:(NSUInteger)index {
    return [IDPArrayInsertChangeModel modelWithIndex:index];
}

+ (id)removeModelWithIndex:(NSUInteger)index {
    return [IDPArrayRemoveChangeModel modelWithIndex:index];
}

+ (id)replaceModelWithIndex:(NSUInteger)index {
    return [IDPArrayReplaceChangeModel modelWithIndex:index];
}

+ (id)moveModelToIndex:(NSUInteger)index
             fromIndex:(NSUInteger)fromIndex
{
    return [IDPArrayMoveChangeModel modelWithToIndex:index
                                           fromIndex:fromIndex];
}


@end
