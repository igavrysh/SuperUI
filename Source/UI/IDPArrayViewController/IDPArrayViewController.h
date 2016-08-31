//
//  IDPArrayViewController.h
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPArrayView.h"
#import "IDPArrayModel.h"
#import "SUIViewController.h"

#import "UIViewController+IDPExtensions.h"
#import "IDPMacros.h"

@protocol IDPModelCell
@property (nonatomic, strong) id    model;

@end

@interface IDPArrayViewController : SUIViewController <
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchBarDelegate,
    IDPChangeableModelObserver
>
@property (nonatomic, strong) IDPArrayModel *arrayModel;

- (IBAction)onAddButton:(id)sender;
- (IBAction)onEditButton:(id)sender;

// methods for override

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath;

@end
