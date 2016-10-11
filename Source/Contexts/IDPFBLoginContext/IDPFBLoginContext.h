//
//  IDPFBLoginContext.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBGetContext.h"

@class IDPFBUser;

@interface IDPFBLoginContext : IDPFBGetContext

+ (instancetype)loginContextWithUser:(IDPFBUser *)user
                      viewController:(UIViewController *)viewController;

- (instancetype)initWithUser:(IDPFBUser *)user
              viewController:(UIViewController *)viewController;


@end
