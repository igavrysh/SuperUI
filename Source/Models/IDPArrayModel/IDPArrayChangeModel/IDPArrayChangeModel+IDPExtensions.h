//
//  IDPArrayChangeModel+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 8/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPArrayChangeModel.h"

#import "IDPArrayModel.h"

@interface IDPArrayChangeModel (IDPExtensions)

- (void)applyToTableView:(UITableView *)tableView;

- (void)applyToArrayModel:(IDPArrayModel *)arrayModel;

@end
