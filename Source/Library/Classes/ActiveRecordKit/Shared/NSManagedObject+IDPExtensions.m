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

#pragma mark -
#pragma mark Public Methods

- (void)saveManagedObject {
    NSError *error = nil;
    
    [[self managedObjectContext] save:&error];
    
    if (error) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}


@end
