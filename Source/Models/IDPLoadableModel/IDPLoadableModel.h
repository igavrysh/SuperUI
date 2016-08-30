//
//  IDPLoadableModel.h
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPModel.h"

typedef NS_ENUM(NSUInteger, IDPLoadableModelState) {
    IDPLoadableModelUnloaded,
    IDPLoadableModelLoaded,
    IDPLoadableModelLoading,
    IDPLoadableModelFailedLoading
};

@class IDPLoadableModel;

@protocol IDPLoadableModelObserver <NSObject>
@optional

- (void)modelDidLoad:(IDPLoadableModel *)model;

- (void)modelWillLoad:(IDPLoadableModel *)model;

- (void)modelDidFailLoading:(IDPLoadableModel *)model;

@end

@interface IDPLoadableModel : IDPModel

- (void)load;

- (void)fillModel;

@end
