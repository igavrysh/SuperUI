//
//  IDPView.h
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPLoadingView;

@interface IDPView : UIView
@property (nonatomic, strong)                               IBOutlet  IDPLoadingView    *loadingView;
@property (nonatomic, assign, getter=isLoadingViewVisible)  BOOL                        loadingViewVisible;

- (IDPLoadingView *)defaultLoadingView;

@end
