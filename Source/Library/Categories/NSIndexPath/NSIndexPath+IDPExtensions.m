//
//  NSIndexPath+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSIndexPath+IDPExtensions.h"

@implementation NSIndexPath (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

+ (NSIndexPath *)indexPathForIndex:(NSUInteger)index {
    return [NSIndexPath indexPathForItem:index inSection:0];
}

@end
