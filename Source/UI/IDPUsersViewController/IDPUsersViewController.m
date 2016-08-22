//
//  IDPUsersViewController.m
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPUser.h"
#import "IDPUsersView.h"
#import "IDPUserCell.h"

#import "IDPMacros.h"
#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, usersView, IDPUsersView)

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usersView.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDPUserCell *cell = [tableView cellWithClass:[IDPUserCell class]];
    
    cell.user = [IDPUser new];
    
    return cell;
}

@end
