//
//  UIViewController+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UIViewController+IDPExtensions.h"

@implementation UIViewController (IDPExtensions)

+ (UIViewController *)viewController {
    return [[UIViewController alloc] initWithNibName:[self nibName] bundle:nil];
}

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

@end
