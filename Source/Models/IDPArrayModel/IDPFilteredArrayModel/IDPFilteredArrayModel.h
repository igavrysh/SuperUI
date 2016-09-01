//
//  IDPFilteredArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 9/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel.h"

@interface IDPFilteredArrayModel : IDPArrayModel <IDPChangeableModelObserver>
@property (nonatomic, strong)   IDPArrayModel   *arrayModel;

- (BOOL)isObjectEligible:(id)object;

- (void)filterArrayModel;

@end
