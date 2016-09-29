//
//  IDPUserCell.m
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUserCell.h"

#import "IDPImageView.h"
#import "IDPUser.h"

@implementation IDPUserCell

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPUser *)user {
    if (_model != user) {
        _model = user;
        
        [self fillWithUser:user];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(IDPUser *)user {
    self.fullNameLabel.text = user.fullName;
    self.userImageView.imageModel = user.imageModel;
}

@end
