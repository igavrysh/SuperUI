//
//  UIWindow+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UIWindow+IDPExtensions.h"

@implementation UIWindow (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (UIWindow *)fullScreenWindow {
    return [[UIWindow alloc] initFullScreenWindow];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (UIWindow *)initFullScreenWindow {
    return [self initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
