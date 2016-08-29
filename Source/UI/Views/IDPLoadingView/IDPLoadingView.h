//
//  IDPLoadingView.h
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

#import "IDPBlockTypes.h"
#import "IDPArrayModel.h"

@interface IDPLoadingView : IDPView <IDPArrayModelObserver>
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, assign, getter=isVisible)     BOOL visible;

+ (instancetype)loadingViewOnSuperView:(UIView *)superView;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
   completionBlock:(IDPVoidBlock)completionBlock;

@end
