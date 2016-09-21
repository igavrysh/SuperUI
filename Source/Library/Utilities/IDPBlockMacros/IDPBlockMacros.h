//
//  IDPBlockMacros.h
//  SuperUI
//
//  Created by Ievgen on 8/23/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPMacros.h"

#define __IDPBlockPerform(operand, operation, block, ...) \
    do { \
        typeof(block) blockToFire = block; \
        if (blockToFire) { \
            operand operation blockToFire(__VA_ARGS__); \
        } \
    } while(0) \

#define IDPBlockPerform(block, ...) \
    __IDPBlockPerform(IDPEmpty, IDPEmpty, block, __VA_ARGS__)

#define IDPReturnBlockPerform(block, ...) \
    __IDPBlockPerform(IDPEmpty, return, block, __VA_ARGS__)

#define IDPAssignBlockPerform(block, variable, ...) \
    __IDPBlockPerform(variable, =, block, __VA_ARGS__)

