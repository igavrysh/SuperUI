//
//  NSManagedObject+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 10/14/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSManagedObject+IDPExtensions.h"

#import "IDPCoreDataManager.h"
#import "NSManagedObjectContext+IDPExtensions.h"

@implementation NSManagedObject (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)managedObject {
    return [NSManagedObjectContext managedObjectWithEntityName:NSStringFromClass([self class])];
}

+ (NSArray *)fetchEntityWithPredicate:(NSPredicate *)predicate
                      sortDescriptors:(NSArray *)sortDescriptors
{
    return [NSManagedObjectContext fetchEntityWithName:NSStringFromClass([self class])
                                             predicate:predicate
                                       sortDescriptors:sortDescriptors];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
                            sortDescriptors:(NSArray *)sortDescriptors
{
    NSFetchRequest *request = [self fetchRequest];
    request.predicate = predicate;
    request.sortDescriptors = sortDescriptors;
    
    return request;
}

+ (NSFetchRequest *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
}

#pragma mark -
#pragma mark Public Methods

- (void)deleteManagedObject {
    [NSManagedObjectContext deleteManagedObject:self];
}

- (void)saveManagedObject {
    [NSManagedObjectContext saveManagedObjectContext];
}

@end
