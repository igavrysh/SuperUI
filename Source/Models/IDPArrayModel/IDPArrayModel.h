//
//  IDPArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPModel.h"

typedef NS_ENUM(NSUInteger, IDPArrayModelState) {
    IDPArrayModelDidUpdateWithChangeModel = IDPModelStateCount,
    IDPArrayModelDidUpdate,
    IDPArrayModelStateCount
};

@class IDPArrayChangeModel;
@class IDPArrayModel;

@protocol IDPChangeableModelObserver <NSObject, IDPLoadableModelObserver>
@optional

- (void)            model:(IDPArrayModel *)model
 didUpdateWithChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)modelDidUpdate:(IDPArrayModel *)model;

@end

@class IDPArrayModel;

@interface IDPArrayModel : IDPModel <NSCopying, IDPChangeableModelObserver>
@property (nonatomic, readonly)         NSUInteger      count;
@property (nonatomic, copy, readonly)   NSArray         *objects;

- (instancetype)initWithObjects:(NSArray *)objects;

- (void)substituteObjectsWithObjects:(NSArray *)objects;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;

- (void)addObjects:(NSArray *)objects;
- (void)addObject:(id)object;

- (void)removeObjects:(NSArray *)objects;
- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)replaceObject:(id)object withObject:(id)replaceObject;
- (void)replaceObjectAtIndex:(NSUInteger)index
                  withObject:(id)object;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;
- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

- (void)save;

@end
