//
//  NSManagedObjectContext+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 10/14/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSManagedObjectContext+IDPExtensions.h"

#import "IDPCoreDataManager.h"

@implementation NSManagedObjectContext (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (id)context {
    return [[IDPCoreDataManager sharedManager] managedObjectContext];
}

+ (id)managedObjectWithEntityName:(NSString *)entityName {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                         inManagedObjectContext:[self context]];
}

+ (NSArray *)fetchEntityWithName:(NSString *)entityName
                       predicate:(NSPredicate *)predicate
                 sortDescriptors:(NSArray *)sortDescriptors
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = predicate;
    request.sortDescriptors = sortDescriptors;
    
    NSError *error = nil;
    NSArray *entities = [[self context] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error fetching %@ objects: %@\n%@", entityName, [error localizedDescription], [error userInfo]);
        abort();
    }
    
    return entities;
}

@end
