//
//  IDPModel.h
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPModelState) {
    IDPModelDidUnload,
    IDPModelDidLoad,
    IDPModelWillLoad,
    IDPModelDidFailLoading,
    IDPModelStateCount
};

@class IDPModel;

@protocol IDPModelObserver <NSObject>
@optional

- (void)modelDidUnload:(IDPModel *)model;

- (void)modelDidLoad:(IDPModel *)model;

- (void)modelWillLoad:(IDPModel *)model;

- (void)modelDidFailLoading:(IDPModel *)model;

@end

@interface IDPModel : IDPObservableObject

- (void)load;

- (BOOL)shouldNotifyOfState:(IDPModelState)state;

// method for override
- (void)performLoading;

@end
