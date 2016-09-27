//
//  IDPFBFriendsViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsViewController.h"

#import "IDPUser.h"
#import "IDPUserArrayModel.h"
#import "IDPFBFriendsContext.h"

@interface IDPFBFriendsViewController ()
@property (nonatomic, strong) IDPUser   *user;

- (void)loadUsers;

@end

@implementation IDPFBFriendsViewController

#pragma mark - Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user {
    self = [super init];
    
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)loadUsers {
    IDPFBContext *context = [IDPFBFriendsContext contextWithUser:self.user
                                                         friends:self.model];
    [context execute];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
