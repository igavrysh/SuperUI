//
//  IDPUserView.h
//  iOSProject
//
//  Created by Ievgen on 7/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUser;

@interface IDPUserView : UIView
@property (nonatomic, strong)   IBOutlet    UILabel             *label;
@property (nonatomic, strong)   IDPUser                         *user;

- (void)fillWithUser:(IDPUser *)user;


@end
