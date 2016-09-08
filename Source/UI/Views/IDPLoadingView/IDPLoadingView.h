//
//  IDPLoadingView.h
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

#import "IDPArrayModel.h"

#import "IDPBlockTypes.h"

@interface IDPLoadingView : UIView
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, assign, getter=isVisible)     BOOL visible;

+ (instancetype)loadingViewInSuperview:(UIView *)superview;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
   completionBlock:(IDPVoidBlock)completionBlock;

@end
