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

#import "IDPGCDQueue.h"
#import "IDPFBFriendsViewController.h"
#import "IDPFBConstants.h"
#import "IDPUser.h"
#import "IDPFBCurrentUser.h"

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
    [super viewDidLoad];
    
    self.model = [IDPFBCurrentUser userWithDetailsForUser:self.model];
    if ([IDPFBCurrentUser isUserLogedIn:self.model]) {
        [self showFriendsViewControllerForUser:self.model];
    }
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadID:(IDPUser *)user {
    IDPAsyncPerformInMainQueue(^{
        [self showFriendsViewControllerForUser:user];
    });
}

@end
