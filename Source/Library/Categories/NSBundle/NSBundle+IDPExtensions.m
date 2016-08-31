//
//  NSBundle+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSBundle+IDPExtensions.h"

#import "UINib+IDPExtensions.h"

@implementation NSBundle (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (id)objectFromMainBundleWithClass:(Class)class {
    return [self objectFromBundle:[NSBundle mainBundle] withClass:class];
}

+ (id)objectFromBundle:(NSBundle *)bundle
             withClass:(Class)class
{
    return [UINib objectFromNibWithClass:class inBundle:bundle];
}

@end
