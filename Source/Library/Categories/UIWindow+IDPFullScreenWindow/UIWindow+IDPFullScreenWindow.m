//
//  UIWindow+IDPFullScreenWindow.m
//  SuperUI
//
//  Created by Ievgen on 8/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UIWindow+IDPFullScreenWindow.h"

@implementation UIWindow (IDPFullScreenWindow)

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
