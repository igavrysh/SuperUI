//
//  NSArray+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPExtensions.h"

@implementation NSArray (IDPExtensions)

#pragma mark - 
#pragma mark Public Methods

- (id)objectWithClass:(Class)class {
    for (id object in self) {
        if ([object isKindOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

@end
