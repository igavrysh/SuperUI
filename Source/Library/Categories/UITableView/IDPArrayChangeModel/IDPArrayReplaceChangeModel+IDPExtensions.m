//
//  IDPArrayReplaceChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayReplaceChangeModel+IDPExtensions.h"

#import "NSIndexPath+IDPExtensions.h"

@implementation IDPArrayReplaceChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
           withAnimation:(UITableViewRowAnimation) animation
{
    NSIndexPath *path = [NSIndexPath indexPathForIndex:self.index];
    
    [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:animation];
}

@end
