//
//  IDPImageView.m
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageView.h"

#import "IDPMacros.h"
#import "IDPImageModel.h"
#import "IDPBlockObservationController.h"

@interface IDPImageView ()
@property (nonatomic, strong)   IDPBlockObservationController   *observer;

- (void)prepareObserver:(IDPBlockObservationController *)observer;

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
        [imageModel dump];
        _imageModel = imageModel;
        
        self.observer = [_imageModel blockObservationControllerWithObserver:self];
        
        [imageModel load];
    }
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark -
#pragma mark Private

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self);
    
    id handler = ^(IDPBlockObservationController *controller, id userInfo) {

            void(^block)(void) = ^ {
                IDPStrongifyAndReturnIfNil(self);

                IDPImageModel *model = controller.observableObject;
                self.contentImageView.image = model.image;
            };
            
            if ([NSThread isMainThread]) {
                block();
            } else {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
    };
    
    [observer setHandler:handler forState:IDPImageModelLoaded];
    [observer setHandler:handler forState:IDPImageModelUnloaded];
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongifyAndReturnIfNil(self);
        
        [self.imageModel load];
    };
    
    [observer setHandler:handler forState:IDPImageModelFailedLoading];
}

@end
