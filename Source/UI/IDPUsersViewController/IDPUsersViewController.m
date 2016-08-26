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
#import "IDPArrayModel.h"

#import "IDPMacros.h"
#import "UITableView+IDPExtensions.h"

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super initWithNibName:@"IDPArrayViewController" bundle:nil];

    return self;
}

#pragma mark -
#pragma mark IDPArrayController overloaded methods

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath;
{
    return [tableView cellWithClass:[IDPUserCell class]];
}


@end
