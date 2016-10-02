//
//  IDPFBCurrentUser.h
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPUser;

@interface IDPFBCurrentUser : NSObject

+ (IDPUser *)userWithID:(IDPUser *)user;
+ (BOOL)isUserLogedIn:(IDPUser *)user;

- (IDPUser *)userWithID:(IDPUser *)user;

@end
