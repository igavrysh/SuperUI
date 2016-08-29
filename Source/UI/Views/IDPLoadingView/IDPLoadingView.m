//
//  IDPLoadingView.m
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLoadingView.h"

#import "IDPMacros.h"
#import "IDPBlockMacros.h"

static const double kIDPLoadingViewShowUpTime = 10.0f;
static const double kIDPLoadingViewDelay = 0.1f;

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
    [self setVisible:visible animated:NO completionBlock:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated
{
    [self setVisible:visible animated:animated completionBlock:nil];
}

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
   completionBlock:(IDPVoidBlock)completionBlock
{
    IDPWeakify(self);
    IDPVoidBlock animations = ^{
        IDPStrongify(self);
        
        if (visible) {
            [[self superview] bringSubviewToFront:self];
        } else {
            [self removeFromSuperview];
        }
    };
    
    [UIView animateWithDuration:animated ? kIDPLoadingViewShowUpTime : 0.f
                          delay:kIDPLoadingViewDelay
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:animations
                     completion:^(BOOL finished) {
                         _visible = visible;
                         
                         IDPBlockPerform(completionBlock);
                     }];
}

#pragma mark -
#pragma mark IDPArrayModelObserver

- (void)arrayModelDidLoad:(IDPArrayModel *)array {
    [self setVisible:NO animated:YES completionBlock:nil];
}

- (void)arrayModelWillLoad:(IDPArrayModel *)array {
    [self setVisible:YES animated:YES completionBlock:nil];
}

@end
