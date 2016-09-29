//
//  IDPUsersViewController.m
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPUser.h"
#import "IDPArrayModel.h"
#import "IDPUserCell.h"
#import "IDPUsersView.h"

#import "UITableView+IDPExtensions.h"

#import "IDPMacros.h"

@implementation IDPUsersViewController

#pragma mark -
#pragma mark Class Methods

+ (NSString *)nibName {
    return @"IDPArrayViewController";
}

#pragma mark -
#pragma mark IDPArrayController overloaded methods

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellWithClass:[IDPUserCell class]];
}

@end
