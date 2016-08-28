//
//  IDPArrayTwoIndexChangeModel.h
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPArrayOneIndexChangeModel.h"

@interface IDPArrayTwoIndexChangeModel : IDPArrayOneIndexChangeModel
@property (nonatomic, readonly)   NSUInteger  fromIndex;

+ (instancetype)modelWithToIndex:(NSUInteger)index
                       fromIndex:(NSUInteger)fromIndex;

- (instancetype)initWithToIndex:(NSUInteger)index
                      fromIndex:(NSUInteger)fromIndex;

@end
