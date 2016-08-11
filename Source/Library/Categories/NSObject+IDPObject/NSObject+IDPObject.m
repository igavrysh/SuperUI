//
//  NSObject+IDPObject.m
//  SuperUI
//
//  Created by Ievgen on 8/10/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSObject+IDPObject.h"

@implementation NSObject (IDPObject)

#pragma mark -
#pragma mark Public Methods

- (id)nilUnwrappedObject {
    return self == [NSNull null] ? nil : self;
}

- (id)nilWrappedObject {
    return !self ? [NSNull null] : self;
}

@end
