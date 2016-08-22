//
//  IDPArrayView.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayView.h"

#import "IDPMacros.h"
#import "IDPArrayModel.h"
#import "IDPBlockObservationController.h"

#import "UITableView+IDPExtensions.h"

@interface IDPArrayView ()

@end


@implementation IDPArrayView

@dynamic editing;

#pragma mark -
#pragma mark Accessors

- (BOOL)isEditing {
    return self.tableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.tableView.editing = editing;
}

#pragma mark -
#pragma mark Public Methods

- (void)applyChangeModel:(IDPArrayChangeModel *)changeModel {
    [self.tableView applyChangeModel:changeModel];
}

- (void)reload {
    [self.tableView reloadData];
}

@end
