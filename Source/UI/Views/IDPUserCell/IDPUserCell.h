//
//  IDPUserCell.h
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPArrayViewController.h"

@class IDPFBUser;
@class IDPImageView;
@class IDPImageModel;

@interface IDPUserCell : UITableViewCell<IDPModelCell, IDPModelObserver>
@property (nonatomic, strong)   IBOutlet UILabel        *fullNameLabel;
@property (nonatomic, strong)   IBOutlet IDPImageView   *userImageView;
@property (nonatomic, strong)   IDPImageModel           *defaultImageModel;
@property (nonatomic, strong)   IDPFBUser               *model;

- (void)fillWithUser:(IDPFBUser *)user;

@end
