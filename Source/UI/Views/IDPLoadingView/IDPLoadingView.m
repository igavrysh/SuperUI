//
//  IDPLoadingView.m
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLoadingView.h"

#import "IDPGCDQueue.h"

#import "UINib+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "IDPMacros.h"
#import "IDPBlockMacros.h"

static const double     kIDPLoadingViewShowUpTime = 0.1f;
static const CGFloat    kIDPDefaultAlpha = 0.7f;

@implementation IDPLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewInSuperview:(UIView *)superview {
    IDPLoadingView *view = [NSBundle objectFromMainBundleWithClass:[self class]];
    
    view.frame = superview.bounds;
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleTopMargin
        | UIViewAutoresizingFlexibleHeight;
    
    return view;
}

#pragma mark -
#pragma mark Initializations and Deallocations


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
        
        IDPAsyncPerformInMainQueue(^{
            self.alpha = visible ? kIDPDefaultAlpha : 0;
        });
    };
    
    [UIView animateWithDuration:animated ? kIDPLoadingViewShowUpTime : 0.f
                     animations:animations
                     completion:^(BOOL finished) {
                         _visible = visible;
                         
                         IDPBlockPerform(completionBlock);
                     }];
}

@end
