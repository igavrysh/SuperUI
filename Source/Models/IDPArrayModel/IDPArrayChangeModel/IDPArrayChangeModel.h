//
//  IDPArrayChangeModel.h
//  SuperUI
//
//  Created by Ievgen on 8/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPArrayModel;

@interface IDPArrayChangeModel : NSObject

+ (id)insertModelWithArrayModel:(IDPArrayModel *)arrayModel
                          index:(NSUInteger)index;

+ (id)removeModelWithArrayModel:(IDPArrayModel *)arrayModel
                          index:(NSUInteger)index;

+ (id)replaceModelWithArrayModel:(IDPArrayModel *)arrayModel
                           index:(NSUInteger)index;

+ (id)moveModelWithArrayModel:(IDPArrayModel *)arrayModel
                      toIndex:(NSUInteger)index
                    fromIndex:(NSUInteger)fromIndex;

@end
