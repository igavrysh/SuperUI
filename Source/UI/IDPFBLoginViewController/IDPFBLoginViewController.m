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
#import "IDPUser.h"

@interface IDPFBLoginViewController ()

- (void)loadUser;

@end

@implementation IDPFBLoginViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.model = [IDPUser new];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (IBAction)onLogin:(UIButton *)button {
    id handler = ^void(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            [self loadUser];
        }
    };
    
    [[FBSDKLoginManager new] logInWithReadPermissions: @[kIDPPublicProfile, kIDPUserFrineds]
                                   fromViewController:self
                                              handler:handler];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadUser {
    IDPFBLoginContext *context = [[IDPFBLoginContext alloc] initWithUser:self.model];
    
    [context execute];
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadId:(IDPUser *)user {
    IDPFBFriendsViewController *controller = [[IDPFBFriendsViewController alloc] initWithUser:user];
    
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

@end
