//
//  IDPUserViewController.m
//  iOSProject
//
//  Created by Ievgen on 7/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUserViewController.h"

#import "IDPUserView.h"

#import "IDPMacros.h"

IDPViewControllerBaseViewProperty(IDPUserViewController, IDPUserView, userView);

@implementation IDPUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPUser *)user {
    if (_user != user) {
        _user = user;
    }
    
    self.userView.user = user;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userView.user = self.user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
