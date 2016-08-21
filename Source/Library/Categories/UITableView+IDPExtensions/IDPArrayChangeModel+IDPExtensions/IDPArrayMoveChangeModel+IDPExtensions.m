//
//  IDPArrayMoveChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayMoveChangeModel+IDPExtensions.h"

#import "NSIndexPath+IDPExtensions.h"

@implementation IDPArrayMoveChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
           withAnimation:(UITableViewRowAnimation) animation
{
    NSIndexPath *toPath = [NSIndexPath indexPathForIndex:self.index];
    NSIndexPath *fromPath = [NSIndexPath indexPathForIndex:self.fromIndex];
    
    [tableView moveRowAtIndexPath:fromPath toIndexPath:toPath];
}

@end
