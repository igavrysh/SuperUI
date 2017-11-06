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

- (void)updateSetValues:(NSSet *)values
                 forKey:(NSString *)key
           mutationKind:(NSKeyValueSetMutationKind)setMutationKind
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

- (void)refreshManagedObject {
    [NSManagedObjectContext refreshManagedObjectContextWithObject:self mergeChanges:YES];
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

- (void)addObjectValue:(id)value forSetKey:(NSString *)key {
    [self addObjectValues:[NSSet setWithObjects:value, nil]
                forSetKey:key];
}

- (void)removeObjectValue:(id)value fromSetKey:(NSString *)key {
    [self removeObjectValues:[NSSet setWithObjects:value, nil]
                  fromSetKey:key];
}

- (void)addObjectValues:(NSSet *)values forSetKey:(NSString *)key {
    [self updateSetValues:values
                   forKey:key
             mutationKind:NSKeyValueUnionSetMutation
              changeBlock:^(NSMutableSet *originalSet) { [originalSet unionSet:values]; }];
}

- (void)removeObjectValues:(NSSet *)values fromSetKey:(NSString *)key {
    [self updateSetValues:values
                   forKey:key
             mutationKind:NSKeyValueMinusSetMutation
              changeBlock:^(NSMutableSet *originalSet) { [originalSet minusSet:values]; }];
}

@end

@implementation NSManagedObject (IDPExtensionsPrivate)

- (void)updateSetValues:(NSSet *)values
                 forKey:(NSString *)key
            mutationKind:(NSKeyValueSetMutationKind)setMutationKind
            changeBlock:(IDPSetChangeBlock)changeBlock
{
    [self willChangeValueForKey:key withSetMutation:setMutationKind usingObjects:values];
    
    NSMutableSet *contextObjects = [self primitiveValueForKey:key];
    
    IDPBlockPerform(changeBlock, contextObjects);
    
    [self didChangeValueForKey:key withSetMutation:setMutationKind usingObjects:values];
}

@end
