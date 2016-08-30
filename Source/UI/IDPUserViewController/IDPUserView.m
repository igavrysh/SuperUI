//
//  IDPUserView.m
//  iOSProject
//
//  Created by Ievgen on 7/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <math.h>

#import "IDPUserView.h"

#import "IDPUser.h"

@implementation IDPUserView

#pragma mark -
#pragma mark Accessories

- (void)setUser:(IDPUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithUser:user];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(IDPUser *)user {
    self.label.text = user.fullName;
}

@end
