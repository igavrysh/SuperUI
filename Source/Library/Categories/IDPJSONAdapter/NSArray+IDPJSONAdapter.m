//
//  NSArray+IDPJSONRepresentation.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPJSONAdapter.h"

#import "NSArray+IDPArrayEnumerator.h"

@protocol IDPSafeArrayAdapter

+ (instancetype)safeArrayWithArray:(id)array;

@end

@interface NSArray  (IDPJSONAdapterPrivate) <IDPSafeArrayAdapter>

@end

@interface NSMutableArray (IDPJSONAdapterPrivate) <IDPSafeArrayAdapter>

@end

@implementation NSArray (IDPJSONAdapter)

#pragma mark - 
#pragma mark IDPJSONAdapter

- (instancetype)JSONRepresentation {
    NSMutableArray *array = [NSMutableArray new];
    
    [self performBlockWithEachObject:^(id<IDPJSONAdapter> object) {
        id processedObject = [object JSONRepresentation];
        
        if (processedObject) {
            [array addObject:processedObject];
        }
    }];
    
    return [[self class] safeArrayWithArray:array];
}

@end

@implementation NSArray (IDPJSONAdapterPrivate)

+ (instancetype)safeArrayWithArray:(NSArray *)array {
    return [NSArray arrayWithArray:array];
}

@end

@implementation NSMutableArray (IDPJSONAdapterPrivate)

+ (instancetype)safeArrayWithArray:(NSMutableArray *)array {
    return [NSMutableArray arrayWithArray:array];
}

@end