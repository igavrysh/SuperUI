//
//  IDPLocalImageModel.h
//  SuperUI
//
//  Created by Ievgen on 9/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"
#import "IDPImageModel.h"

typedef void (^IDPImageLoadingCompletionBlock)(UIImage *image, NSError **error);

@interface IDPLocalImageModel : IDPImageModel
@property (nonatomic, readonly)                     NSURL       *localURL;
@property (nonatomic, readonly, getter=isCached)    BOOL        cached;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block;

@end
