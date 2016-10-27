//
//  IDPFBFriendsViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

#import "IDPModel.h"
#import "IDPFBUser.h"
#import "SUIView.h"
#import "IDPContext.h"

#import "IDPMacros.h"

@class IDPFBUser;
@class IDPFBFriendsArrayModel;

@interface IDPFBFriendsViewController : UIViewController <
    IDPFBUserObserver,
    UITableViewDelegate,
    UITableViewDataSource
>

IDPDefineBaseViewProperty(SUIView, rootView);

- (instancetype)initWithUser:(IDPFBUser *)user;

@end
