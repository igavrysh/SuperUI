//
//  UITableView+IDPExtensions.m
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "UITableView+IDPExtensions.h"

#import "IDPArrayChangeModel.h"

#import "UINib+IDPExtensions.h"

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
    
}

@end
