//
//  IDPCoreDataArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 10/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPCoreDataArrayModel.h"

#import "IDPArrayChangeModel+IDPExtensions.h"

#import "IDPArrayModel+IDPExtensions.h"
#import "NSArray+IDPArrayEnumerator.h"
#import "NSMutableArray+IDPExtensions.h"
#import "NSManagedObject+IDPExtensions.h"
#import "NSManagedObjectContext+IDPExtensions.h"
#import "NSCompoundPredicate+IDPExtensions.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPCacheName, @"Master");

@interface IDPCoreDataArrayModel ()
@property (nonatomic, strong)   NSManagedObject             *containerModel;
@property (nonatomic, strong)   NSString                    *arrayKeyPath;
@property (nonatomic, strong)   NSFetchedResultsController  *controller;

- (void)initFetchResultsController;

- (NSCompoundPredicate *)compoundPredicate;

@end

@implementation IDPCoreDataArrayModel

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)initWithContainerModel:(NSManagedObject *)containerModel
                          arrayKeyPath:(NSString *)arraykeyPath
{
    self = [super init];
    self.containerModel = containerModel;
    self.arrayKeyPath = arraykeyPath;
    
    //[NSFetchedResultsController deleteCacheWithName:kIDPCacheName];
    
    [self initFetchResultsController];
    
    return self;
}

- (void)initFetchResultsController {
    NSFetchRequest *fetchRequest = [[self.containerModel class] fetchRequestWithPredicate:[self compoundPredicate]
                                                                          sortDescriptors:self.sortDescriptors];
    
    NSManagedObjectContext *context = [NSManagedObjectContext context];
    
    
    static NSUInteger cacheCounter = 1;
    NSString *cacheName = [NSString stringWithFormat:@"%lu", cacheCounter];
    
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:cacheName];
}

- (NSCompoundPredicate *)compoundPredicate {
    NSCompoundPredicate *predicate = [NSCompoundPredicate new];
    predicate = [predicate addAndPredicate:self.predicate];
    predicate = [predicate addAndPredicate:self.filterPredicate];
    
    return predicate;
}


#pragma mark -
#pragma mark Accessors

- (void)setController:(NSFetchedResultsController *)controller {
    if (_controller != controller) {
        _controller = controller;
        
        controller.delegate = self;
    }
}

- (NSArray *)objects {
    return [self.controller fetchedObjects];
}

- (NSUInteger)count {
    return self.objects.count;
}

#pragma mark -
#pragma mark Public Methods

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithFormat:@"%K CONTAINS %@", self.arrayKeyPath, self.containerModel];
}

- (NSPredicate *)filterPredicate {
    return nil;
}

- (NSArray *)sortDescriptors {
    return nil;
}

- (void)performLoading {
    NSError *error = nil;
    if (![self.controller performFetch:&error]) {
        NSLog(@"ERROR in %@: %@", [self.class description], [error description]);
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        return index < self.count ? self.objects[index] : nil;
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized(self) {
        return [self.objects indexOfObject:object];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    [self addObject:object];
}

- (void)addObjects:(NSArray *)objects {
    @synchronized(self) {
        [objects performBlockWithEachObject:^(id object) {
            [self addObject:object];
        }];
    }
}

- (void)addObject:(id)object {
    @synchronized(self) {
        [self.containerModel addObjectValue:object
                                  forSetKey:self.arrayKeyPath];
    }
}

- (void)removeObjects:(NSArray *)objects {
    @synchronized(self) {
        [objects performBlockWithEachObject:^(id object) {
            [self removeObject:object];
        }];
    }
}

- (void)removeObject:(id)object {
    @synchronized(self) {
        [self.containerModel removeObjectValue:object
                                    fromSetKey:self.arrayKeyPath];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        id object = self[index];
        
        [self removeObject:object];
    }
}

- (void)replaceObject:(id)object withObject:(id)replaceObject {
    @synchronized(self) {
        [self removeObject:object];
        
        [self addObject:object];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index
                  withObject:(id)object
{
    @synchronized(self) {
        if (index >= self.count) {
            return;
        }
        
        [self replaceObject:self[index] withObject:object];
    }
}

- (void)moveObject:(id)object toIndex:(NSUInteger)index {
}

- (void)moveObjectToIndex:(NSUInteger)index
                fromIndex:(NSUInteger)fromIndex
{
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)object
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    IDPArrayChangeModel *model = nil;

    switch (type) {
        case NSFetchedResultsChangeInsert:
        case NSFetchedResultsChangeUpdate:
            model = [IDPArrayChangeModel insertModelWithArrayModel:self
                                                             index:indexPath.row];
            break;
            
        case NSFetchedResultsChangeDelete:
            model = [IDPArrayChangeModel removeModelWithArrayModel:self
                                                             index:indexPath.row];
            break;
            
        case NSFetchedResultsChangeMove:
            model = [IDPArrayChangeModel moveModelWithArrayModel:self
                                                         toIndex:newIndexPath.row
                                                       fromIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    [self applyChangeModel:model];
}

@end
