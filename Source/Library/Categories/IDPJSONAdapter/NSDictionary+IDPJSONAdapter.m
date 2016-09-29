//
//  NSDictionary+IDPJSONRepresentation.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSDictionary+IDPJSONAdapter.h"

#import "NSDictionary+IDPExtensions.h"

@implementation NSDictionary (IDPJSONAdapter)

#pragma mark -
#pragma mark IDPJSONAdapter

- (instancetype)JSONRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [self performBlockWithEachObject:^(id<IDPJSONAdapter> object, id key) {
        id processedObject = [object JSONRepresentation];
        
        if (processedObject) {
            dictionary[key] = object;
        }
    }];
    
    return [[self class] dictionaryWithDictionary:dictionary];
}

@end
