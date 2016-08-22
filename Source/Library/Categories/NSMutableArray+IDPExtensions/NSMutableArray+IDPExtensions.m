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
    NSInteger delta = index - fromIndex;
    NSInteger deltaI = delta > 0 ? 1 : -1;
    
    for (NSInteger i = fromIndex; i != index; i += deltaI) {
        id object = self[i];
        self[i] = self[i + deltaI];
        self[i + deltaI] = object;
    }
}

@end
