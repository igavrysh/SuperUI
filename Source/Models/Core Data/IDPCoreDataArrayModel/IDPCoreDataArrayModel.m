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

@interface IDPCoreDataArrayModel ()
@property (nonatomic, strong)   NSManagedObject             *containerModel;
@property (nonatomic, strong)   NSString                    *arrayKeyPath;
@property (nonatomic, strong)   NSFetchedResultsController  *controller;

- (void)initFetchResultsController;

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
    
    [self initFetchResultsController];
    
    return self;
}

- (void)initFetchResultsController {
    NSFetchRequest *fetchRequest = [[self.containerModel class] fetchRequestWithPredicate:self.predicate
                                                                          sortDescriptors:self.sortDescriptors];
    
    NSManagedObjectContext *context = [NSManagedObjectContext context];
    
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:@"Master"];
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
    return [[self.controller fetchedObjects] copy];
}

- (NSUInteger)count {
    return self.objects.count;
}

#pragma mark -
#pragma mark Public Methods

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithFormat:@"%K CONTAINS %@",
            self.arrayKeyPath,
            self.containerModel];
}

- (NSArray *)sortDescriptors {
    return nil;
}

- (void)performLoading {
    NSError *error = nil;
    if (![self.controller performFetch:&error]) {
        NSLog(@"ERROR in %@: %@", [self.class description], [error description]);
    }
    
    self.state = !error ? IDPModelDidLoad : IDPModelDidFailLoading;
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
    
}

- (void)


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
            [self applyChangeModel:model];
            break;
            
        case NSFetchedResultsChangeDelete:
            model = [IDPArrayChangeModel removeModelWithArrayModel:self
                                                             index:indexPath.row];
            [self applyChangeModel:model];
            break;
            
        case NSFetchedResultsChangeMove:
            model = [IDPArrayChangeModel moveModelWithArrayModel:self
                                                         toIndex:newIndexPath.row
                                                       fromIndex:indexPath.row];
            [self applyChangeModel:model];
            break;
            
        default:
            break;
    }
}

@end
