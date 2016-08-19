//
//  IDPArrayOneIndexChangeModel.h
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPArrayOneIndexChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger index;

+ (instancetype)modelWithIndex:(NSUInteger)index;

- (instancetype)initWithIndex:(NSUInteger)index;

@end
