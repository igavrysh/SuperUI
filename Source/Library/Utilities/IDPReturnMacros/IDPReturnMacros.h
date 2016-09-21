//
//  IDPReturnMacros.h
//  SuperUI
//
//  Created by Ievgen on 8/23/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPMacros.h"

#define IDPReturnValueIfNil(condition, value) \
    do { \
        if (!(condition)) { \
            return value; \
        } \
    } \
    while(0) \

#define IDPReturnNilIfNil(condition) \
    IDPReturnIfNil(condition, nil)

#define IDPReturnIfNil(condition) \
    IDPReturnValueIfNil(condition, IDPEmpty)
