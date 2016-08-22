//
//  IDPArrayRemoveChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayRemoveChangeModel+IDPExtensions.h"

#import "NSIndexPath+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

@implementation IDPArrayRemoveChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
           withAnimation:(UITableViewRowAnimation) animation
{
    [tableView applyChangeBlock:^{
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathWithIndex:self.index]]
                         withRowAnimation:animation];
    }];
}


@end
