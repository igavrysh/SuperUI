//
//  IDPArrayViewController.h
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPArrayModel;

@interface IDPArrayViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IDPArrayModel *array;

- (IBAction)onAddButton:(id)sender;
- (IBAction)onEditButton:(id)sender;

@end
