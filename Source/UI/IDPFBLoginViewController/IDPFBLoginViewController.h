//
//  IDPFBLoginViewController.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

#import "IDPFBLoginContext.h"

#import "IDPUser.h"

@interface IDPFBLoginViewController : SUIViewController <IDPUserStateObserver>

- (IBAction)onLogin:(UIButton *)button;

@end
