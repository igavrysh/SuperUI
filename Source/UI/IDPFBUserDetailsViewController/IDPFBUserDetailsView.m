//
//  IDPFBUserDetailsView.m
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUserDetailsView.h"

#import "IDPImageView.h"

@interface IDPFBUserDetailsView ()
@property (nonatomic, strong)   IDPFBUser       *user;
@property (nonatomic, strong)   IDPImageModel   *imageModel;

- (void)fillWithUser:(IDPFBUser *)user;

@end

@implementation IDPFBUserDetailsView

#pragma mark -
#pragma mark Accessors

- (void)setUser:(IDPFBUser *)user {
    self.user = user;
    
    [self fillWithUser:user];
}

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (self.userImageView.imageModel != imageModel) {
        [self.userImageView.imageModel removeObserver:self];
        
        [imageModel addObserver:self];
        
        self.userImageView.imageModel = imageModel;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithUser:(IDPFBUser *)user {
    self.nameLabel.text = user.name;
    self.locationLabel.text = user.location;
    self.hometownLabel.text = user.hometown;
    self.imageModel = user.bigImageModel;
}

@end
