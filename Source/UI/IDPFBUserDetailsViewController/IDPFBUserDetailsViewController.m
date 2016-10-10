//
//  IDPFBUserDetailsViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUserDetailsViewController.h"

#import "IDPFBUserDetailsView.h"
#import "IDPUser.h"
#import "IDPFBUserDetailsContext.h"
#import "IDPGCDQueue.h"

#import "IDPMacros.h"
#import "IDPContextHelpers.h"

IDPViewControllerBaseViewProperty(IDPFBUserDetailsViewController, IDPFBUserDetailsView, detailsView);

@interface IDPFBUserDetailsViewController ()
@property (nonatomic, strong)   IDPFBUserDetailsContext   *detailsContext;

- (void)loadUserDetails;

@end

@implementation IDPFBUserDetailsViewController

#pragma mark - 
#pragma mark Accessors

- (void)setModel:(IDPUser *)user {
    [super setModel:user];
    
    if (self.isViewLoaded) {
        self.rootView.model = user;
    }
}

- (void)setDetailsContext:(IDPFBUserDetailsContext *)detailsContext {
    IDPContextSetter(&_detailsContext, detailsContext);
}

#pragma mark -
#pragma mark Private Methods

- (void)loadUserDetails {
    self.detailsContext = [[IDPFBUserDetailsContext alloc] initWithUser:self.model];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUserDetails];
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)userDidLoadDetails:(IDPUser *)user {
    IDPAsyncPerformInMainQueue(^{
        self.detailsView.model = user;
        
        ((IDPUser *)self.model).state = IDPModelDidLoad;
    });
}

@end
