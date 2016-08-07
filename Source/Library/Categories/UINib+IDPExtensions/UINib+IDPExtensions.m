//
//  UINib+IDPExtensions.m
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UINib+IDPExtensions.h"

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
    return [[self nibWithClass:class] objectWithClass:class];
}

#pragma mark -
#pragma mark Public methods

- (id)firstObject {
    return [[self objects] firstObject];
}

- (id)objectWithClass:(Class)class {
    NSArray *objects = [self objects];
    
    for (id object in objects) {
        if ([object isKindOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

- (NSArray *)objects {
    return [self instantiateWithOwner:nil options:nil];
}

@end
