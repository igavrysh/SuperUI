//
//  IDPFBFriendsViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

@class IDPUser;

@interface IDPFBFriendsViewController : SUIViewController <
    UITableViewDelegate,
    UITableViewDataSource>

- (instancetype)initWithUser:(IDPUser *)user;

@end
