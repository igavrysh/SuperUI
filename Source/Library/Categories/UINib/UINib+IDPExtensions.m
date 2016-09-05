//
//  UINib+IDPExtensions.m
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UINib+IDPExtensions.h"

#import "NSArray+IDPExtensions.h"

@implementation UINib (IDPExtensions)

#pragma mark -
#pragma mark Class methods

+ (UINib *)nibWithClass:(Class)cls {
    return [self nibWithClass:cls bundle:nil];
}

+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    NSString *nibName = NSStringFromClass(cls);
    
    return [self nibWithNibName:nibName bundle:bundle];
}

+ (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls inBundle:nil owner:nil];
}

+ (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls inBundle:nil owner:owner];
}

+ (id)objectWithClass:(Class)cls inBundle:(NSBundle *)bundle {
    return [self objectWithClass:cls inBundle:bundle owner:nil];
}

+ (id)objectWithClass:(Class)cls
             inBundle:(NSBundle *)bundle
                owner:(id)owner
{
    UINib *nib = [self nibWithClass:cls bundle:bundle];
    
    return [nib objectWithClass:cls owner:owner];
}

#pragma mark -
#pragma mark Public methods

- (id)objectWithClass:(Class)cls owner:(id)owner {
    return [[self objectsWithOwner:(id)owner] objectWithClass:cls];
}

- (NSArray *)objectsWithOwner:(id)owner {
    return [self instantiateWithOwner:owner options:nil];
}

@end
