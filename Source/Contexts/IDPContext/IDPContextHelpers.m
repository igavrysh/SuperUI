//
//  IDPContextHelpers.m
//  SuperUI
//
//  Created by Ievgen on 10/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPContextHelpers.h"

#import "IDPContext.h"

void IDPContextSetter(IDPContext * __strong *contextField, IDPContext *context) {
    if (*contextField != context) {
        [*contextField cancel];
        
        *contextField = context;
        
        [context execute];
    }
}
