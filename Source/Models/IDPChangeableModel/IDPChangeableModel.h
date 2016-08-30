//
//  IDPChangeableModel.h
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLoadableModel.h"

typedef NS_ENUM(NSUInteger, IDPChangeableModelState) {
    IDPChangeableModelUpdated
};

@class IDPChangeableModel;

@protocol IDPChangeableModelObserver <NSObject>
@optional

- (void)model:(IDPChangeableModel *)model didUpdateWithUserInfo:(id)userInfo;

@end

@interface IDPChangeableModel : IDPLoadableModel

@end
