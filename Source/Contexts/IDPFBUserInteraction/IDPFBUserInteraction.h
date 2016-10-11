//
//  IDPFBCurrentUser.h
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPFBUser;

@interface IDPFBUserInteraction : NSObject

+ (IDPFBUser *)userWithID:(IDPFBUser *)user;
+ (BOOL)isUserLoggedIn:(IDPFBUser *)user;

- (IDPFBUser *)userWithID:(IDPFBUser *)user;

@end
