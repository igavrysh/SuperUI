//
//  NSManagedObject+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 10/14/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (IDPExtensions)

+ (instancetype)managedObject;

+ (NSArray *)fetchEntityWithPredicate:(NSPredicate *)predicate
                      sortDescriptors:(NSArray *)sortDescriptors;

+ (NSFetchRequest *)fetchRequestWithPredicate:(NSPredicate *)predicate
                              sortDescriptors:(NSArray *)sortDescriptors;

+ (NSFetchRequest *)fetchRequest;

- (void)deleteManagedObject;

- (void)saveManagedObject;

- (void)addObjectValue:(id)object forSetKey:(NSString *)key;

- (void)removeObjectValue:(id)object fromSetKey:(NSString *)key;

- (void)addObjectValues:(NSSet *)objects forSetKey:(NSString *)key;

- (void)removeObjectValues:(NSSet *)objects fromSetKey:(NSString *)key;

@end
