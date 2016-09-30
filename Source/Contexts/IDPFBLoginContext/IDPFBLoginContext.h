//
//  IDPFBLoginContext.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBGetContext.h"

@class IDPUser;

@interface IDPFBLoginContext : IDPFBGetContext

+ (instancetype)loginContextWithUser:(IDPUser *)user
                      viewController:(UIViewController *)viewController;

+ (IDPUser *)user;

- (instancetype)initWithUser:(IDPUser *)user
              viewController:(UIViewController *)viewController;


@end
