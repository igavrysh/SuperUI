//
//  IDPArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSObject+IDPObject.h"

@interface IDPArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *data;

@end

@implementation IDPArrayModel

@dynamic count;

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.data.count;
}

#pragma mark -
#pragma mark Public Methods

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (id)objectAtIndex:(NSUInteger)index {
    return index < self.count ? [self.data[index] nilUnwrappedObject] : nil;
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.data indexOfObject:[object nilUnwrappedObject]];
}

- (void)addObject:(id)object {
    [self.data addObject:[object nilUnwrappedObject]];
    
    [self notifyOfStateChange:IDPArrayModelObjectAdded];
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndex:[self indexOfObject:[object nilWrappedObject]]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.data removeObjectAtIndex:index];
    
    [self notifyOfStateChange:IDPArrayModelObjectRemoved];
}

- (void)pasteObject:(id)object atIndex:(NSUInteger)index {
    [self.data insertObject:[object nilWrappedObject] atIndex:index];
    
    [self notifyOfStateChange:IDPArrayModelObjectPasted];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    [self moveObjectFromIndex:[self indexOfObject:object] toIndex:index];
}

- (void)moveObjectFromIndex:(NSUInteger)source toIndex:(NSUInteger)destination {
    if (source >= self.count || destination >= self.count) {
        return;
    }
    
    id object = self[source];
    [self removeObjectAtIndex:source];
    [self pasteObject:object atIndex:destination];
    
    [self notifyOfStateChange:IDPArrayModelObjectMoved];
}

@end
