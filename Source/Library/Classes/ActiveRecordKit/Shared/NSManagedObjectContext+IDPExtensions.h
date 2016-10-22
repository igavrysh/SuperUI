//
//  NSManagedObjectContext+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 10/14/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (IDPExtensions)

+ (id)context;

+ (id)managedObjectWithEntityName:(NSString *)entityName;

+ (NSArray *)fetchEntityWithName:(NSString *)entityName
                       predicate:(NSPredicate *)predicate
                 sortDescriptors:(NSArray *)sortDescriptors;

+ (void)deleteManagedObject:(NSManagedObject *)object;

+ (void)saveManagedObjectContext;

@end
