//
//  UITableView+IDPExtensions.h
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IDPApplyChangeBlock)(void);

@class IDPArrayChangeModel;

@interface UITableView (IDPExtensions)

- (id)cellWithClass:(Class)cls;
- (id)cellWithClass:(Class)cls bundle:(NSBundle *)bundle;

- (void)applyChangeModel:(IDPArrayChangeModel *)model;
- (void)applyChangeModel:(IDPArrayChangeModel *)model
           withAnimation:(UITableViewRowAnimation) animation;

- (void)applyChangeBlock:(IDPApplyChangeBlock)block;

@end
