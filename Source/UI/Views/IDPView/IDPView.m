//
//  IDPView.m
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

#import "IDPLoadingView.h"
#import "IDPGCDQueue.h"

#import "IDPMacros.h"

@interface IDPView ()

@end

@implementation IDPView

#pragma mark -
#pragma mark Class Methods

+ (IDPView *)viewWithFrame:(CGRect)frame {
    IDPView *view = [[self alloc] initWithFrame:frame];
    
    return view;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.loadingView = [self defaultLoadingView];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        self.loadingView = [self defaultLoadingView];
    }
}

#pragma mark -
#pragma mark Accessors 

- (void)setLoadingView:(IDPLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        
        [self addSubview:loadingView];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)showLoadingView {
    IDPPrintMethod;
    
    IDPLoadingView *loadingView = self.loadingView;
    
    IDPSyncPerformInMainQueue(^{
        [self bringSubviewToFront:loadingView];
        
        [loadingView setVisible:YES animated:YES];
        
    });
}

- (void)hideLoadingView {
    IDPPrintMethod;
    
    IDPSyncPerformInMainQueue(^{
        [self.loadingView setVisible:NO animated:YES];
    });
}

- (IDPLoadingView *)defaultLoadingView {
    return [IDPLoadingView loadingViewInSuperview:self];
}

@end
