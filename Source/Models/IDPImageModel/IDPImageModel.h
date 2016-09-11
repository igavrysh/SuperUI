//
//  IDPImageModel.h
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"

@interface IDPImageModel : IDPModel
@property (nonatomic, readonly)     UIImage     *image;
@property (nonatomic, readonly)     NSURL       *url;
@property (nonatomic, readonly)     NSURL       *localURL;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

@end
