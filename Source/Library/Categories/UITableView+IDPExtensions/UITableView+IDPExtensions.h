//
//  UITableView+IDPExtensions.h
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPArrayChangeModel;

@interface UITableView (IDPExtensions)

- (id)cellWithClass:(Class)class;

- (id)cellWithClass:(Class)class bundle:(NSBundle *)bundle;

- (void)applyChangeModel:(IDPArrayChangeModel *)model;

@end
