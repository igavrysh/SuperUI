//
//  NSArray+IDPJSONRepresentation.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPJSONAdapter.h"

#import "NSArray+IDPArrayEnumerator.h"


@interface NSArray  (IDPJSONAdapterPrivate)

+ (NSArray *)arrayPrivateWithArray:(NSArray *)array;

@end

@interface NSMutableArray (IDPJSONAdapterPrivate)

+ (NSMutableArray *)arrayPrivateWithArray:(NSMutableArray *)array;

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
    
    return [[self class] arrayPrivateWithArray:array];
}

@end

@implementation NSArray (IDPJSONAdapterPrivate)

+ (NSArray *)arrayPrivateWithArray:(NSArray *)array {
    return [NSArray arrayWithArray:array];
}

@end

@implementation NSMutableArray (IDPJSONAdapterPrivate)

+ (NSMutableArray *)arrayPrivateWithArray:(NSMutableArray *)array {
    return [NSMutableArray arrayWithArray:array];
}

@end