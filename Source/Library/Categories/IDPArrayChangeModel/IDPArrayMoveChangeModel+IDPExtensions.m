//
//  IDPArrayMoveChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayMoveChangeModel+IDPExtensions.h"

#import "IDPArrayModel.h"

#import "NSIndexPath+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

@implementation IDPArrayMoveChangeModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView
        withRowAnimation:(UITableViewRowAnimation) animation
{
}

- (void)applyToArrayModel:(IDPArrayModel *)arrayModel {
    IDPArrayModel *applyArrayModel = self.arrayModel;
    NSUInteger toIndex = self.index;
    NSUInteger fromIndex = self.fromIndex;
    
    id toObject = applyArrayModel[toIndex];
    
    if (self.arrayModel.count == arrayModel.count
        && arrayModel[fromIndex] == toObject)
    {
        [arrayModel moveObjectToIndex:toIndex fromIndex:fromIndex];
    }
}

@end
