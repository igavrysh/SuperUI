//
//  IDPFBFriendsViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

#import "IDPModel.h"
#import "SUIView.h"
#import "IDPContext.h"

#import "IDPMacros.h"

@class IDPFBUser;
@class IDPFBFriendsArrayModel;

@interface IDPFBFriendsViewController : UIViewController <
    IDPModelObserver,
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) IDPFBFriendsArrayModel    *friends;

IDPDefineBaseViewProperty(SUIView, rootView);

- (instancetype)initWithUser:(IDPFBUser *)user;

@end
