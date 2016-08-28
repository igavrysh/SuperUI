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

#import "UITableView+IDPExtensions.h"

NSString * const kIDPEditButtonItemEdit = @"Edit";
NSString * const kIDPEditButtonItemDone = @"Done";

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
    
    self.editButtonItem.title = [self editBarButtonTitle];
}

- (void)setFiltered:(BOOL)filtered {
    _filtered = filtered;
    
    //if (filtered) {
    //    self.tableView.editing = false;
    //}
}

- (BOOL)canMoveRows {
    return !self.filtered && self.editing;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)editBarButtonTitle {
    return self.editing ? kIDPEditButtonItemDone : kIDPEditButtonItemEdit;
}

@end
