//
//  IDPCachedUserArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 9/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUserArrayModel.h"

@interface IDPCachedUserArrayModel : IDPUserArrayModel

+ (NSString *)modelPlistName;
+ (NSString *)cachePath;
+ (BOOL)cacheExists;

@end
