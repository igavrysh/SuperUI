//
//  NSDictionary+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSDictionary+IDPExtensions.h"

@implementation NSDictionary (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)performBlockWithEachObject:(void (^)(id object, id key))block {
    if (!block) {
        return;
    }
    
    [[self allKeys] enumerateObjectsUsingBlock:^(id key, NSUInteger index, BOOL *stop) {
        block(self[key], key);
    }];
}

@end
