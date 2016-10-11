//
//  IDPFBFriendsContext.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBContext.h"

@class IDPFBUser;

@interface IDPFBFriendsContext : IDPFBContext

+ (instancetype)contextWithUser:(IDPFBUser *)user;

- (instancetype)initWithUser:(IDPFBUser *)user;

@end
