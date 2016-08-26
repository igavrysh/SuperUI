//
//  IDPArrayViewController.h
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPMacros.h"
#import "IDPArrayView.h"
#import "IDPArrayModel.h"

#import "UIViewController+IDPExtensions.h"

@protocol IDPModelCell
@property (nonatomic, strong) id    model;

@end

@interface IDPArrayViewController : UIViewController <
    UITableViewDelegate,
    UITableViewDataSource,
    IDPArrayModelObserver
>
@property (nonatomic, strong) IDPArrayModel *arrayModel;

- (IBAction)onAddButton:(id)sender;
- (IBAction)onEditButton:(id)sender;

// methods for override

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath;

@end
