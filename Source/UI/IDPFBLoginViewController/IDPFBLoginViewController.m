//
//  IDPFBLoginViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBLoginViewController.h"

#import "IDPFBFriendsViewController.h"
#import "IDPFBConstants.h"
#import "IDPUser.h"

@interface IDPFBLoginViewController ()

@end

@implementation IDPFBLoginViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (IBAction)onLogin:(UIButton *)button {
    IDPUser *user  = [IDPUser new];
    self.model = user;
    
    IDPFBLoginContext *context = [[IDPFBLoginContext alloc] initWithUser:user
                                                          viewController:self];
    
    [context execute];
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadID:(IDPUser *)user {
    IDPFBFriendsViewController *controller = [[IDPFBFriendsViewController alloc] initWithUser:user];
    
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

@end
