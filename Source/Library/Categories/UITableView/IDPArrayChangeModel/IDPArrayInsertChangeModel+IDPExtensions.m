//
//  IDPArrayInsertChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayInsertChangeModel+IDPExtensions.h"

#import "NSIndexPath+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

@implementation IDPArrayInsertChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
        withRowAnimation:(UITableViewRowAnimation) animation
{
    [tableView applyChangeBlock:^{
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForIndex:self.index]]
                         withRowAnimation:animation];
    }];
}

@end
