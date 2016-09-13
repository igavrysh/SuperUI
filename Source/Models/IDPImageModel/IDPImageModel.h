//
//  IDPImageModel.h
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"

@protocol IDPImageContainer <NSObject>
@property   (nonatomic, readonly) UIImage   *image;

@end


@interface IDPImageModel : IDPModel<IDPImageContainer>

+ (id)imageWithURL:(NSURL *)url;

- (id)initWithURL:(NSURL *)url;

@end
