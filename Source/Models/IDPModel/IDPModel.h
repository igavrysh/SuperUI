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
    IDPLoadableModelWillLoad,
    IDPLoadableModelFailedLoading,
    IDPLoadableModelStateCount
};

@class IDPModel;

@protocol IDPLoadableModelObserver <NSObject>
@optional

- (void)modelDidLoad:(IDPModel *)model;

- (void)modelWillLoad:(IDPModel *)model;

- (void)modelDidFailLoading:(IDPModel *)model;

@end

@interface IDPModel : IDPObservableObject

- (void)load;

- (void)performLoading;

@end
