//
//  IDPUserCell.m
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUserCell.h"

#import "IDPImageView.h"
#import "IDPFBUser.h"
#import "IDPFBImage.h"
#import "IDPBlockTypes.h"
#import "IDPGCDQueue.h"

#import "IDPDispatchMacros.h"

static NSString * const kIDPNoImageName = @"image";
static NSString * const kIDPNoImageExtension = @"jpg";

@interface IDPUserCell ()
@property (nonatomic, strong)   IDPImageModel *imageModel;

+ (IDPImageModel *)defaultImageModel;

@end

@implementation IDPUserCell

@dynamic imageModel;

#pragma mark -
#pragma mark Class Methods

+ (IDPImageModel *)defaultImageModel {
    IDPFactoryBlock block = ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:kIDPNoImageName
                                             withExtension:kIDPNoImageExtension];
        
        return [IDPImageModel imageWithURL:url];
    };
    
    IDPReturnAfterSettingVariableWithBlockOnce(block);
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPFBUser *)user {
    if (_model != user) {
        _model = user;
        
        [self fillWithUser:user];
    }
}

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (self.userImageView.imageModel != imageModel) {
        [self.userImageView.imageModel removeObserverObject:self];
        
        [imageModel addObserverObject:self];
        
        self.userImageView.imageModel = imageModel;
    }
}

- (IDPImageModel *)imageModel {
    return self.userImageView.imageModel;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    //Scaling?
    self.userImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.userImageView.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(IDPFBUser *)user {
    self.fullNameLabel.text = user.fullName;
    
    self.imageModel = user.profileImage.imageModel;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidFailLoading:(IDPModel *)model {
    IDPAsyncPerformInBackgroundQueue(^{
        self.imageModel = [IDPUserCell defaultImageModel];
    });
}

@end
