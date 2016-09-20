//
//  IDPImageModel.h
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"

typedef void (^IDPImageLoadingCompletionBlock)(UIImage *image, NSError *error);

@interface IDPImageModel : IDPModel
@property (nonatomic, readonly)     UIImage     *image;
@property (nonatomic, readonly)     NSURL       *url;

+ (id)imageWithURL:(NSURL *)url;

- (id)initWithURL:(NSURL *)url;

- (void)performLoading;
- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block;

@end
