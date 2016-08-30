//
//  UITableView+IDPExtensions.m
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UITableView+IDPExtensions.h"

#import "IDPArrayChangeModel.h"
#import "IDPArrayInsertChangeModel.h"

#import "UINib+IDPExtensions.h"
#import "IDPArrayChangeModel+IDPExtensions.h"
#import "IDPArrayRemoveChangeModel+IDPExtensions.h"
#import "IDPArrayInsertChangeModel+IDPExtensions.h"
#import "IDPArrayMoveChangeModel+IDPExtensions.h"
#import "IDPArrayReplaceChangeModel+IDPExtensions.h"

#import "IDPBlockMacros.h"
#import "IDPReturnMacros.h"

@implementation UITableView (IDPExtensions)

#pragma mark - 
#pragma mark Public methods

- (id)cellWithClass:(Class)class {
    return [self cellWithClass:class bundle:nil];
}

- (id)cellWithClass:(Class)class bundle:(NSBundle *)bundle; {
    NSString *cellClass = NSStringFromClass(class);
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellClass];
    
    if (!cell) {
        UINib *nib = [UINib nibWithClass:class bundle:bundle];
        cell = [nib objectWithClass:class];
    }
    
    return cell;
}

- (void)applyChangeModel:(IDPArrayChangeModel *)model {
    [self applyChangeModel:model withAnimation:UITableViewRowAnimationAutomatic];
}

- (void)applyChangeModel:(IDPArrayChangeModel *)model
           withAnimation:(UITableViewRowAnimation) animation
{
    [self applyChangeBlock:^{
        [model applyToTableView:self withRowAnimation:animation];
    }];
}

#pragma mark -
#pragma mark Private Methods

- (void)applyChangeBlock:(IDPApplyChangeBlock)block {
    IDPReturnIfNil(block);
    
    [self beginUpdates];
    
    IDPPerformBlock(block);
    
    [self endUpdates];
}

@end
