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
    NSUInteger toIndex = self.index;
    NSUInteger fromIndex = self.fromIndex;
    NSInteger deltaIndex = toIndex - fromIndex > 0 ? 1 : -1;
    
    NSIndexPath *toPath = [NSIndexPath indexPathForIndex:toIndex];
    NSIndexPath *fromPath = [NSIndexPath indexPathForIndex:fromIndex];
    NSIndexPath *previousToPath = [NSIndexPath indexPathForIndex:toIndex + deltaIndex];
    
    [tableView reloadRowsAtIndexPaths:@[toPath, previousToPath, fromPath] withRowAnimation:animation];
    
    //[tableView reloadData];
    //[tableView moveRowAtIndexPath:fromPath toIndexPath:toPath];
}

@end
