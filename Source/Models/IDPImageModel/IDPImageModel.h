//
//  IDPImageModel.h
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPImageModelState) {
    IDPImageModelUnloaded,
    IDPImageModelLoading,
    IDPImageModelLoaded,
    IDPImageModelFailedLoading
};

@interface IDPImageModel : IDPObservableObject
@property (nonatomic, readonly)     UIImage     *image;
@property (nonatomic, readonly)     NSURL       *url;

@property (nonatomic, readonly, getter=isLoaded)    BOOL loaded;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)load;
- (void)dump;

@end
