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
#import "IDPFBUser.h"
#import "IDPFBUserInteraction.h"

#import "IDPContextHelpers.h"

@interface IDPFBLoginViewController ()
@property (nonatomic, strong)   IDPFBLoginContext   *loginContext;

- (void)showFriendsViewControllerForUser:(IDPFBUser *)user;

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
    IDPFBUser *user  = [IDPFBUser managedObject];
    self.model = user;
    
    self.loginContext = [[IDPFBLoginContext alloc] initWithUser:user
                                                 viewController:self];
    
    [self.loginContext execute];
}

#pragma mark -
#pragma mark Private Methods

- (void)showFriendsViewControllerForUser:(IDPFBUser *)user {
    IDPFBFriendsViewController *controller = [[IDPFBFriendsViewController alloc] initWithUser:user];
    
    [self.navigationController pushViewController:controller
                                         animated:NO];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IDPFBUser *user = [IDPFBUserInteraction user];
    self.model = user;
    
    if ([IDPFBUserInteraction isUserLoggedIn:user]) {
        [self showFriendsViewControllerForUser:user];
    }
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadId:(IDPFBUser *)user {
    IDPAsyncPerformInMainQueue(^{
        [self showFriendsViewControllerForUser:user];
    });
}

@end
