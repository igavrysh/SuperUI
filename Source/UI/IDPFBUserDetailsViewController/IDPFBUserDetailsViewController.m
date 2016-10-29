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

@interface IDPFBUserDetailsViewController ()
@property (nonatomic, strong)   IDPFBUser               *user;
@property (nonatomic, strong)   IDPFBUserDetailsContext *detailsContext;

- (void)loadUserDetails;

@end

IDPViewControllerBaseViewProperty(IDPFBUserDetailsViewController, IDPFBUserDetailsView, detailsView);

@implementation IDPFBUserDetailsViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPFBUser *)user {
    self = [super init];
    self.user = user;
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

IDPBaseViewGetterSynthesize(SUIView, rootView);

- (void)setUser:(IDPFBUser *)user {
    if (_user != user) {
        [_user removeObserverObject:self];
        
        _user = user;
        
        [user addObserverObject:self];
        
        if (self.isViewLoaded) {
            self.rootView.model = self.user;
        }
    }
}

- (void)setDetailsContext:(IDPFBUserDetailsContext *)detailsContext {
    IDPContextSetter(&_detailsContext, detailsContext);
}

#pragma mark -
#pragma mark Private Methods

- (void)loadUserDetails {
    self.detailsContext = [IDPFBUserDetailsContext contextWithModel:self.user];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUserDetails];
}

#pragma mark -
#pragma mark IDPUserStateObserver

- (void)modelDidLoad:(IDPUser *)user {
    IDPAsyncPerformInMainQueue(^{
        self.detailsView.model = user;
    });
}

#pragma mark -
#pragma mark IDPFBUserObserver

- (void)userDidLoadDetails:(IDPFBUser *)user {
    IDPPrintMethod;
    
    self.rootView.loadingViewVisible = NO;
}

@end
