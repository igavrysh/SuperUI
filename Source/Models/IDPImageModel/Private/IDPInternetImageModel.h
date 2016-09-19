//
//  IDPGlobalImageModel.h
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLocalImageModel.h"

@interface IDPInternetImageModel : IDPLocalImageModel
@property (nonatomic, readonly)                     NSURL       *localURL;
@property (nonatomic, readonly, getter=isCached)    BOOL        cached;

- (void)cancelLoad;

@end
