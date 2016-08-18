//
//  IDPArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

@class IDPArrayObject;

typedef NS_ENUM(NSUInteger, IDPArrayModelState) {
    IDPArrayModelObjectAdded,
    IDPArrayModelObjectRemoved,
    IDPArrayModelObjectMoved,
    IDPArrayModelObjectPasted
};

@interface IDPArrayModel : IDPObservableObject
@property (nonatomic, readonly)     NSMutableArray  *data;
@property (nonatomic, readonly)     NSUInteger      count;

- (instancetype)initWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)addObject:(id)object;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)pasteObject:(id)object atIndex:(NSUInteger)index;

- (void)moveObject:(id)object toIndex:(NSUInteger)index;
- (void)moveObjectFromIndex:(NSUInteger)source toIndex:(NSUInteger)destination;

@end
