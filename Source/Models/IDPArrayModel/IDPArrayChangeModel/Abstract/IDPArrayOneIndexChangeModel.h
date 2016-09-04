//
//  IDPArrayOneIndexChangeModel.h
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPArrayModel;

@interface IDPArrayOneIndexChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger      index;
@property (nonatomic, readonly) IDPArrayModel   *arrayModel;

+ (instancetype)modelWithArrayModel:(IDPArrayModel *)arrayModel
                              index:(NSUInteger)index;

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel
                             index:(NSUInteger)index;

@end
