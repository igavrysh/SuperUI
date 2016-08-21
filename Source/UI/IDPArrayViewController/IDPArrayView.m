//
//  IDPArrayView.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayView.h"

#import "IDPMacro.h"
#import "IDPArrayModel.h"
#import "IDPBlockObservationController.h"

#import "UITableView+IDPExtensions.h"

@interface IDPArrayView ()


@end


@implementation IDPArrayView

- (void)applyChangeModel:(IDPArrayChangeModel *)changeModel {
    [self.tableView applyChangeModel:changeModel];
}

- (void)reload {
    [self.tableView reloadData];
}

@end
