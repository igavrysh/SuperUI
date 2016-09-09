//
//  IDPArrayRandomModel.h
//  SuperUI
//
//  Created by Ievgen on 8/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel.h"

#import "IDPFilteredUserArrayModel.h"

static const NSUInteger kIDPArrayModelSampleSize = 5;

@interface IDPUserArrayModel : IDPArrayModel
@property (nonatomic, readonly)                         NSString    *plistName;
@property (nonatomic, readonly)                         NSString    *cachePath;
@property (nonatomic, readonly, getter=isCacheExists)   BOOL        cacheExists;

@end
