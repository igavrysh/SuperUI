//
//  IDPFBUserDetailsViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUser.h"

#import "SUIView.h"

@class IDPFBUser;

@interface IDPFBUserDetailsViewController : UIViewController <IDPFBUserObserver>

IDPDefineBaseViewProperty(SUIView, rootView);

- (instancetype)initWithUser:(IDPFBUser *)user;

@end
