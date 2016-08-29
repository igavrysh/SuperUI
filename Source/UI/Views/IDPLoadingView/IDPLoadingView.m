//
//  IDPLoadingView.m
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLoadingView.h"

@implementation IDPLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewOnSuperView:(UIView *)superView {
    IDPLoadingView *view = [self new];
    [superView addSubview:view];
    
    return view;
}

#pragma mark -
#pragma mark Accessors

- (void)setVisible:(BOOL)visible {
    
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated completionBlock: {
    
}



@end
