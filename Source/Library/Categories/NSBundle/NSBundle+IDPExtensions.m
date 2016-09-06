//
//  NSBundle+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSBundle+IDPExtensions.h"

#import "UINib+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

@implementation NSBundle (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil options:nil];
}

+ (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls owner:owner options:nil];
}

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options
{
    return [[self mainBundle] objectWithClass:cls owner:owner options:options];
}

#pragma mark -
#pragma mark Public Methods

- (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil options:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls owner:owner options:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options {
    NSString *nibName = NSStringFromClass(cls);
    
    NSArray *objects = [self loadNibNamed:nibName owner:owner options:options];
    
    return [objects objectWithClass:cls];
}

@end
