//
//  DCIModel.h
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, DCIModelState) {
    DCIModelDidUnload,
    DCIModelDidLoad,
    DCIModelWillLoad,
    DCIModelDidFailLoading,
    DCIModelStateCount
};

@class DCIModel;

@protocol DCIModelObserver <NSObject>
@optional

- (void)modelDidUnload:(DCIModel *)model;

- (void)modelDidLoad:(DCIModel *)model;

- (void)modelWillLoad:(DCIModel *)model;

- (void)modelDidFailLoading:(DCIModel *)model;

@end


@interface DCIModel : IDPObservableObject

- (void)save;

- (void)load;

@end
