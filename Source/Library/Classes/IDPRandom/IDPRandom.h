//
//  IDPRandom.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float minValue;
    float maxValue;
} IDPFloatRange;

typedef struct {
    NSInteger minValue;
    NSInteger maxValue;
} IDPIntRange;

static inline
IDPFloatRange IDPFloatRangeCreate(float value1, float value2) {
    IDPFloatRange range;
    range.minValue = MIN(value1, value2);
    range.maxValue = MAX(value1, value2);
    
    return range;
}

static inline
IDPIntRange IDPIntRangeCreate(NSInteger value1, NSInteger value2) {
    IDPIntRange range;
    range.minValue = MIN(value1, value2);
    range.maxValue = MAX(value1, value2);
    
    return range;
}

static inline
float IDPRandomFloatWithinRange(IDPFloatRange range) {
    return range.minValue + arc4random() / (float)UINT32_MAX * (range.maxValue - range.minValue);
}

static inline
float IDPRandomFloatWithMinAndMaxValue(float value1, float value2) {
    return IDPRandomFloatWithinRange(IDPFloatRangeCreate(value1, value2));
}

static inline
NSInteger IDPRandomIntWithinRange(IDPIntRange range) {
    return range.minValue + arc4random_uniform((UInt32)(range.maxValue - range.minValue + 1));
}

static inline
NSInteger IDPRandomIntWithMinAndMaxValue(NSInteger value1, NSInteger value2) {
    return IDPRandomIntWithinRange(IDPIntRangeCreate(value1, value2));
}

static inline
NSUInteger IDPRandomUIntWithMaxValue(NSUInteger value) {
    return IDPRandomIntWithinRange(IDPIntRangeCreate(0, value));
}

static inline
NSUInteger IDPRandomUIntWithMinAndMaxValue(NSUInteger value1, NSUInteger value2) {
    return IDPRandomIntWithinRange(IDPIntRangeCreate(value1, value2));
}

static inline
BOOL IDPRandomBool() {
    return arc4random_uniform(1);
}
