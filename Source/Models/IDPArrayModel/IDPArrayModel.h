//
//  IDPArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPModel.h"

typedef NS_ENUM(NSUInteger, IDPChangeableModelState) {
    IDPChangeableModelUpdated = IDPLoadableModelStateCount,
    IDPChangeableModelReloading,
    IDPChangeableModelReloaded
};

@class IDPChangeableModel;
@class IDPArrayModel;

@protocol IDPChangeableModelObserver <NSObject, IDPLoadableModelObserver>
@optional

- (void)model:(IDPArrayModel *)model didUpdateWithUserInfo:(IDPChangeableModel *)userInfo;

- (void)modelWillReload:(IDPArrayModel *)model;

- (void)modelDidReload:(IDPArrayModel *)model;

@end

@class IDPArrayModel;

@interface IDPArrayModel : IDPModel <NSCopying, IDPChangeableModelObserver>
@property (nonatomic, readonly)         NSUInteger      count;
@property (nonatomic, copy, readonly)   NSArray         *objects;

- (instancetype)initWithObjects:(NSArray *)objects;

// ToDo: remove this and make objects mutable
- (void)substituteObjectsWithObjects:(NSArray *)objects;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)addObject:(id)object;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;
- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

- (IDPArrayModel *)filteredArrayUsingFilterString:(NSString *)filter;

@end
