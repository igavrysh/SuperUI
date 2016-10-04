//
//  IDPFBUserDetailsContext.h
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBGetContext.h"

@class IDPUser;

@interface IDPFBUserDetailsContext : IDPFBGetContext

+ (instancetype)contextWithUser:(IDPUser *)user;

- (instancetype)initWithUser:(IDPUser *)user;

@end
