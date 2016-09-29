//
//  NSArray+IDPJSONRepresentation.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPJSONRepresentation.h"

#import "NSArray+IDPArrayEnumerator.h"

@implementation NSArray (IDPJSONRepresentation)

#pragma mark - 
#pragma mark IDPJSONAdapter

- (instancetype)jsonRepresentation {
    NSMutableArray *array = [NSMutableArray new];
    
    [self performBlockWithEachObject:^(id<IDPJSONAdapter> object) {
        id processedObject = [object jsonRepresentation];
        
        if (processedObject) {
            [array addObject:processedObject];
        }
    }];
    
    return [array copy];
}

@end
