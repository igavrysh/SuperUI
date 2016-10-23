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

#import "IDPBlockMacros.h"

typedef void (^IDPSetChangeBlock)(NSMutableSet *originalSet);

@interface NSManagedObject (IDPExtensionsPrivate)

- (void)updateSetForKey:(NSString *)key
            withObjects:(NSSet *)objects
        setMutationKind:(NSKeyValueSetMutationKind)setMutationKind
            changeBlock:(IDPSetChangeBlock)changeBlock;

@end

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

- (void)setObjectValue:(id)value forKey:(NSString *)key {
    [self willChangeValueForKey:key];
    
    [self setPrimitiveValue:value forKey:key];
    
    [self didChangeValueForKey:key];
}

- (id)objectValueForKey:(NSString *)key {
    id object = nil;
    
    [self willAccessValueForKey:key];
    
    object = [self primitiveValueForKey:key];
    
    [self didAccessValueForKey:key];
    
    return object;
}

- (void)addObjectValue:(id)object forSetKey:(NSString *)key {
    [self addObjectValues:[NSSet setWithObjects:object, nil]
                forSetKey:key];
}

- (void)removeObjectValue:(id)object fromSetKey:(NSString *)key {
    [self removeObjectValues:[NSSet setWithObjects:object, nil]
                  fromSetKey:key];
}

- (void)addObjectValues:(NSSet *)objects forSetKey:(NSString *)key {
    [self updateSetForKey:key
              withObjects:objects
          setMutationKind:NSKeyValueUnionSetMutation
              changeBlock:^(NSMutableSet *originalSet) { [originalSet unionSet:objects]; }];
}

- (void)removeObjectValues:(NSSet *)objects fromSetKey:(NSString *)key {
    [self updateSetForKey:key
              withObjects:objects
          setMutationKind:NSKeyValueMinusSetMutation
              changeBlock:^(NSMutableSet *originalSet) { [originalSet minusSet:objects]; }];
}

@end

@implementation NSManagedObject (IDPExtensionsPrivate)

- (void)updateSetForKey:(NSString *)key
            withObjects:(NSSet *)objects
        setMutationKind:(NSKeyValueSetMutationKind)setMutationKind
            changeBlock:(IDPSetChangeBlock)changeBlock
{
    [self willChangeValueForKey:key withSetMutation:setMutationKind usingObjects:objects];
    
    NSMutableSet *contextObjects = [self primitiveValueForKey:key];
    
    IDPBlockPerform(changeBlock, contextObjects);
    
    [self didChangeValueForKey:key withSetMutation:setMutationKind usingObjects:objects];
}

@end
