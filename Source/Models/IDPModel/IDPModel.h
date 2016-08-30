//
//  IDPModel.h
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

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

@interface IDPModel : IDPObservableObject

- (void)load;

- (void)performLoading;

@end
