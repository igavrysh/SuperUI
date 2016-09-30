//
//  IDPFBFriendDetailsView.m
//  SuperUI
//
//  Created by Ievgen on 9/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendDetailsView.h"

#import "IDPUser.h"
#import "IDPImageView.h"

@interface IDPFBFriendDetailsView ()
@property (nonatomic, strong)   IDPImageModel *imageModel;

- (void)fillWithUser:(IDPUser *)user;

@end

@implementation IDPFBFriendDetailsView

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPUser *)user {
    [super setModel:user];
    
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

- (void)fillWithUser:(IDPUser *)user {
    self.nameLabel.text = user.name;
    self.locationLabel.text = user.location;
    self.hometownLabel.text = user.hometown;
    
    self.imageModel = user.bigImageModel;
}

@end
