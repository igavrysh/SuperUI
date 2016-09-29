//
//  NSDictionary+IDPJSONRepresentation.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPJSONRepresentation.h"

#import "NSDictionary+IDPExtensions.h"

@implementation NSDictionary (IDPJSONRepresentation)

#pragma mark -
#pragma mark IDPJSONAdapter

- (instancetype)jsonRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [self performBlockWithEachObject:^(id<IDPJSONAdapter> object, id key) {
        id processedObject = [object jsonRepresentation];
        
        if (processedObject) {
            dictionary[key] = object;
        }
    }];
    
    return [[self class] dictionaryWithDictionary:dictionary];
}

@end
