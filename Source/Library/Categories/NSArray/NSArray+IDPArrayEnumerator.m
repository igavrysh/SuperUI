//
//  NSArray+IDPArrayEnumerator.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPArrayEnumerator.h"

#import "IDPRandom.h"

@implementation NSArray (IDPArrayEnumerator)

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)objectsWithCount:(NSUInteger)count block:(id(^)())block {
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSUInteger index = 0; index < count; index++) {
        [array addObject:block()];
    }

    return [array copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)performBlockWithEachObject:(void (^)(id object))block {
    if (!block) {
        return;
    }
    
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger idex, BOOL *stop) {
        block(object);
    }];
}

- (id)randomObject {
    NSUInteger count = [self count];
    if (count == 0) {
        return nil;
    }
    
    return [self objectAtIndex:IDPRandomUIntWithMaxValue(count - 1)];
}

- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id object))block {
    if (!block) {
        return nil;
    }
    
    id arrayFilter = ^BOOL(id object, NSDictionary<NSString *,id> *bindings) {
        return block(object);
    };
    
    NSArray *result = [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:arrayFilter]];
    
    return result;
}


@end
