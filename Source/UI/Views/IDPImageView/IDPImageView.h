//
//  IDPImageView.h
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPImageModel.h"

@interface IDPImageView : UIView <IDPImageModelObserver>
@property (nonatomic, strong)   IBOutlet UIImageView    *contentImageView;
@property (nonatomic, strong)   IDPImageModel           *imageModel;

@end
