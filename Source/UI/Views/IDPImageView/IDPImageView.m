//
//  IDPImageView.m
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPGCDQueue.h"
#import "IDPImageModel.h"

#import "IDPMacros.h"

@interface IDPImageView ()

@end

@implementation IDPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleHeight;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark Accessors

-  (void)setContentImageView:(UIImageView *)contentImageView {
    if (contentImageView != _contentImageView) {
        [_contentImageView removeFromSuperview];
        
        _contentImageView = contentImageView;
        
        [self addSubview:contentImageView];
    }
}

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        
        [imageModel addObserver:self];
        
        [imageModel load];
    }
}

#pragma mark -
#pragma mark IDPImageModelObserver

- (void)modelDidUnload:(IDPImageModel *)imageModel {
    IDPAsyncPerformInMainQueue(^{
        self.contentImageView.image = imageModel.image;
    });
    
    [super modelDidUnload:imageModel];
}

- (void)modelWillLoad:(IDPImageModel *)imageModel {
    [super modelWillLoad:imageModel];
}

- (void)modelDidLoad:(IDPImageModel *)imageModel {
    IDPAsyncPerformInMainQueue(^{
        self.contentImageView.image = imageModel.image;
        
        [super modelDidLoad:imageModel];
    });
}

- (void)modelDidFailLoading:(IDPImageModel *)imageModel {
    IDPAsyncPerformInMainQueue(^{        
        [super modelDidFailLoading:imageModel];
    });
}

@end
