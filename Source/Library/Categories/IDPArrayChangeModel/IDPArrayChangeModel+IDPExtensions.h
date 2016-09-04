//
//  IDPArrayChangeModel+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 8/21/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPArrayChangeModel.h"

@interface IDPArrayChangeModel (IDPExtensions)

- (void)applyToTableView:(UITableView *)tableView
           withRowAnimation:(UITableViewRowAnimation) animation;

- (void)applyToArrayModel:(IDPArrayModel *)arrayModel;

@end
