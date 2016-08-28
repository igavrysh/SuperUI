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
- (void)        arrayModel:(IDPArrayModel *)array
  didUpdateWithChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)arrayModelDidLoad:(IDPArrayModel *)array;

- (void)arrayModelWillLoad:(IDPArrayModel *)array;

- (void)arrayModelDidFailLoading:(IDPArrayModel *)array;

@end

@interface IDPArrayModel : IDPObservableObject <NSCopying>
@property (nonatomic, readonly)         NSUInteger      count;
@property (nonatomic, copy, readonly)   NSArray         *objects;

- (instancetype)initWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)addObject:(id)object;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;
- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

- (void)load;

- (IDPArrayModel *)filteredArrayUsingFilterString:(NSString *)filter;

@end
