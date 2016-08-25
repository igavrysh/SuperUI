//
//  IDPArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPArrayObject;
@class IDPArrayModel;
@class IDPArrayChangeModel;

typedef NS_ENUM(NSUInteger, IDPArrayModelState) {
    IDPArrayModelUpdated,
    IDPArrayModelLoaded,
    IDPArrayModelLoading,
    IDPArrayModelFailedLoading
};

@protocol IDPArrayModelObserver <NSObject>
@optional
- (void)arrayModelDidUpdate:(IDPArrayModel *)array
            withChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)arrayModelDidLoad:(IDPArrayModel *)array
          withChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)arrayModelDidStartLoading:(IDPArrayModel *)array
                  withChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)arrayModelDidFailLoading:(IDPArrayModel *)array
                 withChangeModel:(IDPArrayChangeModel *)changeModel;

@end

@interface IDPArrayModel : IDPObservableObject
@property (nonatomic, readonly)     NSUInteger      count;

- (instancetype)initWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;
- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

- (void)load;


@end
