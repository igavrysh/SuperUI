//
//  IDPFBFriendDetailsViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendDetailsViewController.h"

#import "IDPFBFriendDetailsView.h"
#import "IDPUser.h"
#import "IDPFBFriendDetailsContext.h"

#import "IDPMacros.h"

IDPViewControllerBaseViewProperty(IDPFBFriendDetailsViewController, IDPFBFriendDetailsView, detailsView);

@interface IDPFBFriendDetailsViewController ()
@property (nonatomic, strong)   IDPFBFriendDetailsContext   *detailsContext;

- (void)loadUserDetails;

@end

@implementation IDPFBFriendDetailsViewController

#pragma mark - 
#pragma mark Accessors

- (void)setModel:(IDPUser *)user {
    [super setModel:user];
    
    if (self.isViewLoaded) {
        self.rootView.model = user;
    }
}

- (void)setDetailsContext:(IDPFBFriendDetailsContext *)detailsContext {
    if (_detailsContext != detailsContext) {
        [_detailsContext cancel];
        
        _detailsContext = detailsContext;
        
        [detailsContext execute];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)loadUserDetails {
    self.detailsContext = [[IDPFBFriendDetailsContext alloc] initWithUser:self.model];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    self.rootView.model = self.model;
    
    [self loadUserDetails];
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadDetails:(IDPUser *)user {
    self.detailsView.model = user;
    ((IDPUser *)self.model).state = IDPModelDidLoad;
}

@end
