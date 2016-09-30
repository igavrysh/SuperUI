//
//  IDPFBFriendDetailsView.h
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIView.h"

@class IDPImageView;
@class IDPUser;

@interface IDPFBFriendDetailsView : SUIView
@property (nonatomic, strong)   IBOutlet    IDPImageView    *userImageView;
@property (nonatomic, strong)   IBOutlet    UILabel         *nameLabel;
@property (nonatomic, strong)   IBOutlet    UILabel         *locationLabel;
@property (nonatomic, strong)   IBOutlet    UILabel         *hometownLabel;

@end
