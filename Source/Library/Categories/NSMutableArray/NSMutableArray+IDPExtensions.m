//
//  NSMutableArray+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"

@implementation NSMutableArray (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)moveObjectToIndex:(NSUInteger)index
                fromIndex:(NSUInteger)fromIndex
{
    id object = self[fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:object atIndex:index];
}

- (void)addObjectWithNilCheck:(id)object {
    if (object) {
        [self addObject:object];
    }
}

@end
