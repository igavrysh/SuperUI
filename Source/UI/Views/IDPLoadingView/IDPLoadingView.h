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

@interface IDPLoadingView : UIView
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, assign, getter=isVisible)     BOOL visible;

+ (instancetype)loadingVieWithFrame:(CGRect)frame;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
   completionBlock:(IDPVoidBlock)completionBlock;

@end
