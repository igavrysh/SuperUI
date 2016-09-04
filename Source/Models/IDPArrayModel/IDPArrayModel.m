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
@property (nonatomic, strong)   NSMutableArray  *mutableObjects;

@end

@implementation IDPArrayModel

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObjects:nil];
}

- (instancetype)initWithObjects:(NSArray *)objects {
    self = [super init];
    
    self.mutableObjects = [NSMutableArray new];
   
    [objects performBlockWithEachObject:^(id object) {
        [self insertObject:object atIndex:0];
    }];

    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.mutableObjects.count;
}

- (NSArray *)objects {
    return [self.mutableObjects copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)substituteObjectsWithObjects:(NSArray *)objects {
    self.mutableObjects = [objects mutableCopy];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (id)objectAtIndex:(NSUInteger)index {
    return index < self.count ? self.mutableObjects[index] : nil;
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.mutableObjects indexOfObject:object];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    [self.mutableObjects insertObject:object atIndex:index];
    
    IDPArrayChangeModel *model = [IDPArrayChangeModel insertModelWithArrayModel:self
                                                                          index:index];
    [self notifyOfModelUpdateWithChange:model];
}

- (void)addObject:(id)object {
    [self insertObject:object atIndex:self.count];
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    
    if (NSNotFound == index) {
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.mutableObjects removeObjectAtIndex:index];

    IDPArrayChangeModel *model = [IDPArrayChangeModel removeModelWithArrayModel:self
                                                                          index:index];
    [self notifyOfModelUpdateWithChange:model];
}

- (void)replaceObjectAtIndex:(NSUInteger)index
                  withObject:(id)object
{
    [self.mutableObjects replaceObjectAtIndex:index withObject:object];
    
    IDPArrayChangeModel *model = [IDPArrayChangeModel replaceModelWithArrayModel:self
                                                                           index:index];
    [self notifyOfModelUpdateWithChange:model];
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
    [self moveObjectToIndex:index fromIndex:[self indexOfObject:object]];
}

- (void)moveObjectToIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    if (fromIndex >= self.count || index >= self.count) {
        return;
    }
    
    [self.mutableObjects moveObjectToIndex:index fromIndex:fromIndex];
    
    IDPArrayChangeModel *model = [IDPArrayChangeModel moveModelWithArrayModel:self
                                                                      toIndex:index
                                                                    fromIndex:fromIndex];
    [self notifyOfModelUpdateWithChange:model];
}

- (IDPArrayModel *)filteredArrayUsingFilterString:(NSString *)filter {
    return [self copy];
}

#pragma mark - 
#pragma mark Private Methods

- (void)notifyOfModelUpdateWithChange:(IDPArrayChangeModel *)changeModel {
    [self notifyOfStateChange:IDPChangeableModelUpdatedWithChangeModel
                   withObject:changeModel];
}

#pragma mark - 
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    IDPArrayModel *model = [self copyWithZone:zone];
    
    model.mutableObjects = [self.mutableObjects copyWithZone:zone];
    
    return model;
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPChangeableModelUpdatedWithChangeModel:
            return @selector(model:didUpdateWithChangeModel:);
            
        case IDPChangeableModelUpdated:
            return @selector(modelDidUpdate:);
        
        default:
            return [super selectorForState:state];
    }
}

@end
