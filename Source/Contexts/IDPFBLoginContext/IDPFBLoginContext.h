//
//  IDPFBLoginContext.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBContext.h"

@class IDPUser;

@interface IDPFBLoginContext : IDPFBContext

+ (instancetype)loginContextWithUser:(IDPUser *)user;

- (instancetype)initWithUser:(IDPUser *)user;

@end
