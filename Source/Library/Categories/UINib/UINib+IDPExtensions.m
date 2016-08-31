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

+ (UINib *)nibWithClass:(Class)class {
    return [self nibWithClass:class bundle:nil];
}

+ (UINib *)nibWithClass:(Class)class bundle:(NSBundle *)bundle {
    NSString *nibName = NSStringFromClass(class);
    
    return [self nibWithNibName:nibName bundle:bundle];
}

+ (id)objectFromNibWithClass:(Class)class {
    return [self objectFromNibWithClass:class inBundle:nil];
}

+ (id)objectFromNibWithClass:(Class)class
                    inBundle:(NSBundle *)bundle
{
    return [[self nibWithClass:class bundle:bundle] objectWithClass:class];
}

#pragma mark -
#pragma mark Public methods

- (id)objectWithClass:(Class)class {
    return [[self objects] objectWithClass:class];
}

- (NSArray *)objects {
    return [self instantiateWithOwner:nil options:nil];
}

@end
