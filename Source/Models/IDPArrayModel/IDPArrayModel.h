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

- (IDPArrayObject *)objectAtIndexedSubscript:(NSUInteger)index;
- (IDPArrayObject *)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)addObject:(IDPArrayObject *)object;

- (void)removeObject:(IDPArrayObject *)object;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)pasteObject:(IDPArrayObject *)object atIndex:(NSUInteger)index;

- (void)moveObject:(IDPArrayObject *)object toIndex:(NSUInteger)index;
- (void)moveObjectFromIndex:(NSUInteger)source toIndex:(NSUInteger)destination;

@end
