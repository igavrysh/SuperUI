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


- (id)objectValueForKey:(NSString *)key;

- (void)setObjectValue:(id)value forKey:(NSString *)key;


- (void)addObjectValue:(id)value forSetKey:(NSString *)key;

- (void)removeObjectValue:(id)value fromSetKey:(NSString *)key;


- (void)addObjectValues:(NSSet *)values forSetKey:(NSString *)key;

- (void)removeObjectValues:(NSSet *)values fromSetKey:(NSString *)key;

@end
