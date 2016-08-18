//
//  IDPArrayChangeModel.h
//  SuperUI
//
//  Created by Ievgen on 8/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPArrayChangeModel : NSObject

+ (id)insertModelWithIndex:(NSUInteger)index;

+ (id)removeModelWithIndex:(NSUInteger)index;

+ (id)replaceModelWithIndex:(NSUInteger)index;

+ (id)moveModelToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;


@end
