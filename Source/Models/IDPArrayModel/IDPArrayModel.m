//
//  IDPArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "IDPArrayObject.h"

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

- (IDPArrayObject *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (IDPArrayObject *)objectAtIndex:(NSUInteger)index {
    return index < self.count ? self.data[index] : nil;
}

- (NSUInteger)indexOfObject:(IDPArrayObject *)object {
    return [self.data indexOfObject:object];
}

- (void)addObject:(IDPArrayObject *)object {
    [self.data addObject:object];
    
    [self notifyOfStateChange:IDPArrayModelObjectAdded];
}

- (void)removeObject:(IDPArrayObject *)object {
    [self removeObjectAtIndex:[self indexOfObject:object]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.data removeObjectAtIndex:index];
    
    [self notifyOfStateChange:IDPArrayModelObjectRemoved];
}

- (void)pasteObject:(IDPArrayObject *)object atIndex:(NSUInteger)index {
    [self.data insertObject:object atIndex:index];
    
    [self notifyOfStateChange:IDPArrayModelObjectPasted];
}

- (void)moveObject:(IDPArrayObject *)object toIndex:(NSUInteger)index {
    [self moveObjectFromIndex:[self indexOfObject:object] toIndex:index];
}

- (void)moveObjectFromIndex:(NSUInteger)source toIndex:(NSUInteger)destination {
    if (source >= self.count || destination >= self.count) {
        return;
    }
    
    IDPArrayObject *object = self[source];
    [self removeObjectAtIndex:source];
    [self pasteObject:object atIndex:destination];
    
    [self notifyOfStateChange:IDPArrayModelObjectMoved];
}

@end
