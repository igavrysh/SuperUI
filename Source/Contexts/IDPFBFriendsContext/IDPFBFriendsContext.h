//
//  IDPFBFriendsContext.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBContext.h"

@class IDPUser;
@class IDPUserArrayModel;

@interface IDPFBFriendsContext : IDPFBContext

+ (instancetype)contextWithUser:(IDPUser *)user;

- (instancetype)initWithUser:(IDPUser *)user;

@end
