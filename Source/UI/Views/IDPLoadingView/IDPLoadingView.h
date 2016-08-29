//
//  IDPLoadingView.h
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

@interface IDPLoadingView : IDPView
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, assign, getter=isVisible)     BOOL visible;

+ (instancetype)loadingViewOnSuperView:(UIView *)superView;



@end
