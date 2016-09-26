//
//  IDPFBLoginContext.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPContext.h"

@class UIViewController;

@interface IDPFBLoginContext : IDPContext

+ (instancetype)loginContextWithViewController:(UIViewController *)viewController;

- (instancetype)initWithViewController:(UIViewController *)viewController;

@end
