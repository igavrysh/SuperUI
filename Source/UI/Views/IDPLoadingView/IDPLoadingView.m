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

static const double     kIDPLoadingViewShowUpTime = 10.0f;
static const double     kIDPLoadingViewDelay = 0.1f;
static const CGFloat    kIDPDefaultAlpha = 0.7f;

@implementation IDPLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingVieWithFrame:(CGRect)frame {
    IDPLoadingView *view = [[self alloc] initWithFrame:frame];
    
    return view;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.spinner = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:NO completionBlock:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
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
            self.alpha = kIDPDefaultAlpha;
        } else {
            self.alpha = 0;
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

@end
