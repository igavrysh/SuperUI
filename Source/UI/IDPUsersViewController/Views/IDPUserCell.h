//
//  IDPUserCell.h
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUser;

@interface IDPUserCell : UITableViewCell
@property (nonatomic, strong)   IBOutlet UILabel        *fullNameLabel;
@property (nonatomic, strong)   IBOutlet UIImageView    *userImageView;

@property (nonatomic, strong)   IDPUser     *user;

- (void)fillWithModel:(IDPUser *)user;

@end
