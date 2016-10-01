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

#import "IDPContextHelpers.h"

@interface IDPFBLoginViewController ()
@property (nonatomic, strong)   IDPFBLoginContext   *loginContext;

- (void)showFriendsViewControllerForUser:(IDPUser *)user;

@end

@implementation IDPFBLoginViewController

#pragma mark -
#pragma mark Accessors

- (void)setLoginContext:(IDPFBLoginContext *)loginContext {
    IDPContextSetter(&_loginContext, loginContext);
}

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
    
    self.loginContext = [[IDPFBLoginContext alloc] initWithUser:user
                                                 viewController:self];
}

#pragma mark -
#pragma mark Private Methods

- (void)showFriendsViewControllerForUser:(IDPUser *)user {
    IDPFBFriendsViewController *controller = [[IDPFBFriendsViewController alloc] initWithUser:user];
    
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    IDPUser *user = [IDPFBLoginContext user];
    if (user) {
        [self showFriendsViewControllerForUser:user];
    }
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadID:(IDPUser *)user {
    [self showFriendsViewControllerForUser:user];
}

@end
