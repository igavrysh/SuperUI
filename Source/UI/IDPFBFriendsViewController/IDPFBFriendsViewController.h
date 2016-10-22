//
//  IDPFBFriendsViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

@class IDPFBUser;

@interface IDPFBFriendsViewController : SUIViewController <
    UITableViewDelegate,
    UITableViewDataSource>

- (instancetype)initWithUser:(IDPFBUser *)user;

@end
