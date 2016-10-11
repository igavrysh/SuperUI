//
//  IDPFBCurrentUser.h
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPUser;

@interface IDPFBUserInteraction : NSObject

+ (IDPUser *)userWithID:(IDPUser *)user;
+ (BOOL)isUserLoggedIn:(IDPUser *)user;

- (IDPUser *)userWithID:(IDPUser *)user;

@end
