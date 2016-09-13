//
//  SUIImageView.m
//  SuperUI
//
//  Created by Ievgen on 9/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIImageView.h"

#import "IDPImageModel.h"
#import "IDPGCDQueue.h"

@interface SUIImageView ()
@property (nonatomic, strong) UIImageView   *contentImageView;

- (void)fillWithModel:(IDPImageModel *)model;

- (void)initSubviews;

@end

@implementation SUIImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initSubviews];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initSubviews];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(IDPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeObserver:self];
        
        [imageModel addObserver:self];
        
        _imageModel = imageModel;
        
        [self fillWithModel:imageModel];
    }
}

#pragma mark -
#pragma mark Private 

- (void)fillWithModel:(IDPImageModel *)model {
    self.contentImageView.image = model.image;
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
#pragma mark IDPLoadableModelObserver

- (void)modelDidUnload:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = NO;
    });
}

- (void)modelDidLoad:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = NO;
    });
}

- (void)modelWillLoad:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = YES;
    });
}

- (void)modelDidFailLoading:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = NO;
    });
}

@end
