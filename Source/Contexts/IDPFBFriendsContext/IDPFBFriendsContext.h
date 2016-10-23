//
//  IDPFBFriendsContext.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBContext.h"

@class IDPFBUser;
@class IDPFBFriendsArrayModel;

@interface IDPFBFriendsContext : IDPFBContext

+ (instancetype)contextWithFBUser:(IDPFBUser *)user
                          friends:(IDPFBFriendsArrayModel *)friends;

- (instancetype)initWithFBUser:(IDPFBUser *)user
                       friends:(IDPFBFriendsArrayModel *)friends;

@end
