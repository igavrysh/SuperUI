//
//  IDPArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel.h"

#import "IDPArrayChangeModel.h"

#import "IDPGCDQueue.h"
#import "NSArray+IDPArrayEnumerator.h"
#import "NSMutableArray+IDPExtensions.h"

@interface IDPArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *array;

@end

@implementation IDPArrayModel

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.array = nil;
}

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    
    self.array = [NSMutableArray new];
   
    [array performBlockWithEachObject:^(id object) {
        [self insertObject:object atIndex:0];
    }];

    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.array.count;
}

#pragma mark -
#pragma mark Public Methods

- (IDPArrayObject *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (IDPArrayObject *)objectAtIndex:(NSUInteger)index {
    return index < self.count ? self.array[index] : nil;
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.array indexOfObject:object];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    [self.array insertObject:object atIndex:index];
    
    [self notifyOfModelUpdateWithChange:[IDPArrayChangeModel insertModelWithIndex:index]];
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndex:[self indexOfObject:object]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.array removeObjectAtIndex:index];

    [self notifyOfModelUpdateWithChange:[IDPArrayChangeModel removeModelWithIndex:index]];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    [self moveObjectToIndex:index fromIndex:[self indexOfObject:object]];
}

- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    if (fromIndex >= self.count || index >= self.count) {
        return;
    }
    
    [self.array moveObjectToIndex:index fromIndex:fromIndex];
    
    [self notifyOfModelUpdateWithChange:[IDPArrayChangeModel moveModelToIndex:index
                                                                    fromIndex:fromIndex]];
}

#pragma mark - 
#pragma mark Private Methods

- (void)notifyOfModelUpdateWithChange:(IDPArrayChangeModel *)changeModel {
    [self notifyOfStateChange:IDPArrayModelUpdated withObject:changeModel];
}

- (void)load {
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPArrayModelUpdated:
            return @selector(arrayModel: didUpdateWithChangeModel:);
            
        case IDPArrayModelLoaded:
            return @selector(arrayModelDidLoad:);
            
        case IDPArrayModelLoading:
            return @selector(arrayModelDidStartLoading:);
            
        case IDPArrayModelFailedLoading:
            return @selector(arrayModelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
