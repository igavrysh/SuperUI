//
//  IDPArrayView.h
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPArrayChangeModel;

@interface IDPArrayView : UIView
@property (nonatomic, strong)                   IBOutlet UITableView  *tableView;
@property (nonatomic, assign, getter=isEditing) BOOL                  editing;

- (void)applyChangeModel:(IDPArrayChangeModel *)changeModel;

- (void)reload;

@end
