//
//  IDPFBUserDetailsView.h
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUser.h"

@class IDPImageView;

@interface IDPFBUserDetailsView : UIView <IDPFBUserStateObserver>
@property (nonatomic, strong)   IBOutlet    IDPImageView    *userImageView;
@property (nonatomic, strong)   IBOutlet    UILabel         *nameLabel;
@property (nonatomic, strong)   IBOutlet    UILabel         *locationLabel;
@property (nonatomic, strong)   IBOutlet    UILabel         *hometownLabel;

@end
