//
//  IDPModel.h
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

typedef void(^IDPModelBlock)(id model);

typedef NS_ENUM(NSUInteger, IDPLoadableModelState) {
    IDPLoadableModelLoaded,
    IDPLoadableModelLoading,
    IDPLoadableModelFailedLoading
};

@protocol IDPLoadableModel <NSObject>
- (void)load;
@end


@interface IDPModel : IDPObservableObject <IDPLoadableModel>

- (void)load;


@end
