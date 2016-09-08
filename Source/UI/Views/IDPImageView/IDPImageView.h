//
//  IDPImageView.h
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SUIView.h"
#import "IDPImageModel.h"

@interface IDPImageView : SUIView
@property (nonatomic, strong)   IBOutlet UIImageView    *contentImageView;
@property (nonatomic, strong)   IDPImageModel           *imageModel;

@end
