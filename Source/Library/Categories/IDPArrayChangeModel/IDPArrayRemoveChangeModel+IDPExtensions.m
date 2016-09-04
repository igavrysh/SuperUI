//
//  IDPArrayRemoveChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayRemoveChangeModel+IDPExtensions.h"

#import "IDPArrayModel.h"

#import "NSIndexPath+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

@implementation IDPArrayRemoveChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
        withRowAnimation:(UITableViewRowAnimation) animation
{
    [tableView applyChangeBlock:^{
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForIndex:self.index]]
                         withRowAnimation:animation];
    }];
}

- (void)applyToArrayModel:(IDPArrayModel *)arrayModel {
    NSUInteger index = self.index;
    
    [arrayModel removeObjectAtIndex:index];
}

@end
