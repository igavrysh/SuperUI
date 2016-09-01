//
//  IDPFilteredUserArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 9/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFilteredArrayModel.h"

@class IDPUser;

@interface IDPFilteredUserArrayModel : IDPFilteredArrayModel
@property (nonatomic, strong)   NSString        *filter;

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel
                            filter:(NSString *)filter;

- (BOOL)isObjectEligible:(IDPUser *)user;

@end
