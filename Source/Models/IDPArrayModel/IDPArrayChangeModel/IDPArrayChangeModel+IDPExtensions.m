//
//  IDPArrayChangeModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 8/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayChangeModel+IDPExtensions.h"

@implementation IDPArrayChangeModel (IDPExtensions)

#pragma mark - 
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)applyToArrayModel:(IDPArrayModel *)arrayModel {
    [self doesNotRecognizeSelector:_cmd];
}

@end
