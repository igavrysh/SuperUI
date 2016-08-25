//
//  IDPImageView.m
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPMacros.h"
#import "IDPGCDQueue.h"
#import "IDPImageModel.h"

@interface IDPImageView ()

@end

@implementation IDPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.contentImageView = nil;
}

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
        
        [imageModel dump];
        _imageModel = imageModel;
        
        [imageModel addObserver:self];
        
        [imageModel load];
    }
}

#pragma mark -
#pragma mark IDPImageModelObserver

- (void)imageModelDidUnload:(IDPImageModel *)imageModel {
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        self.contentImageView.image = imageModel.image;
    });
}

- (void)imageModelDidStartLoading:(IDPImageModel *)imageModel {
}

- (void)imageModelDidLoad:(IDPImageModel *)imageModel {
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        self.contentImageView.image = imageModel.image;
    });
}

- (void)imageModelDidFailLoading:(IDPImageModel *)imageModel {
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        [self.imageModel load];
    });
}

@end
