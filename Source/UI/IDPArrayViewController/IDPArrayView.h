//
//  IDPArrayView.h
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SUIView.h"

@class IDPArrayChangeModel;

@interface IDPArrayView : SUIView
@property (nonatomic, strong)   IBOutlet UITableView        *tableView;
@property (nonatomic, strong)   IBOutlet UINavigationBar    *navigationBar;
@property (nonatomic, strong)   IBOutlet UIBarButtonItem    *editButtonItem;

@property (nonatomic, assign, getter=isEditing)     BOOL    editing;
@property (nonatomic, assign, getter=isFiltered)    BOOL    filtered;
@property (nonatomic, readonly)                     BOOL    canMoveRows;

@end
