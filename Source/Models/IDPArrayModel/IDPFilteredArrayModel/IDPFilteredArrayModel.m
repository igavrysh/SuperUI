//
//  IDPFilteredArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 9/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFilteredArrayModel.h"

#import "IDPMacros.h"

@interface IDPFilteredArrayModel ()
@property (nonatomic, strong)   IDPArrayModel   *filteredObjects;
@property (nonatomic, strong)   NSString        *filterString;

@end

@implementation IDPFilteredArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObjects:nil];
}

- (instancetype)initWithObjects:(NSArray *)objects {
    self = [super initWithObjects:objects];
    
    self.filteredObjects = [[IDPArrayModel alloc] initWithObjects:objects];
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

- (NSArray *)objects {
    return [self.filteredObjects objects];
}

- (NSUInteger)count {
    return self.filteredObjects.count;
}

#pragma mark -
#pragma mark Public Methods

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self.filteredObjects objectAtIndexedSubscript:index];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.filteredObjects objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.filteredObjects indexOfObject:object];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super insertObject:object atIndex:index];
    }];
    
    if ([self objectShouldNotBeFiltered:object]) {
        [self insertObject:object atIndex:index < self.count ? index : self.count];
    }
}

- (void)addObject:(id)object {
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super addObject:object];
    }];
    
    if ([self objectShouldNotBeFiltered:object]) {
        [self.filteredObjects addObject:object];
    }
}

- (void)removeObject:(id)object {
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super removeObject:object];
    }];
    
    [self.filteredObjects removeObject:object];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    id object = [super objectAtIndex:index];
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super removeObjectAtIndex:index];
    }];
    
    [self.filteredObjects removeObject:object];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super moveObject:object toIndex:index];
    }];
}

- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    IDPWeakify(self);
    [self performBlockWithoutNotification:^{
        IDPStrongify(self);
        
        [super moveObjectToIndex:index fromIndex:fromIndex];
    }];
}

- (BOOL)objectShouldBeFiltered:(id)object {
    return NO;
}

- (BOOL)objectShouldNotBeFiltered:(id)object {
    return [self objectShouldBeFiltered:object];
}

@end
