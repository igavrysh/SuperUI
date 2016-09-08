//
//  IDPArrayModel+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayModel+IDPExtensions.h"

#import "IDPArrayChangeModel+IDPExtensions.h"

@implementation IDPArrayModel (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (void)applyChangeModel:(IDPArrayChangeModel *)model {
    [model applyToArrayModel:self];
}

@end
