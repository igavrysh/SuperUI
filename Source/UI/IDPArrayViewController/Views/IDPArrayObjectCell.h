//
//  IDPArrayObjectCell.h
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPImageView;
@class IDPArrayObject;

@interface IDPArrayObjectCell : UITableViewCell
@property (nonatomic, strong)   IBOutlet UILabel        *nameLabel;
@property (nonatomic, strong)   IBOutlet IDPImageView   *imageView;

@property (nonatomic, strong)   IDPArrayObject          *object;

- (void)fillWithObject:(IDPArrayObject *)object;

@end
