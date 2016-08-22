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
        if (toFire) { \
            operand operation blockToFire(__VA_ARGS__); \
        } \
    } while(0) \

#define IDPBlockPerform(block) \
    __IDPPerformBlock(IDPEmpty, IDPEmpty, block, __VA_ARGS__)

#define IDPReturnBlockPerform(block) \
    __IDPPerformBlock(IDPEmpty, return, block, __VA_ARGS__)

#define IDPAssignBlockPerform(block, variable) \
    __IDPPerformBlock(variable, =, block, __VA_ARGS__)

