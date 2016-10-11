//
//  IDPFBLoginViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

#import "IDPFBLoginContext.h"

#import "IDPFBUser.h"

@interface IDPFBLoginViewController : SUIViewController <IDPFBUserStateObserver>

- (IBAction)onLogin:(UIButton *)button;

@end
