//
//  IDPErrorMacros.h
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMacros.h"

#define IDPPrintError(error) \
    do { \
        if (!error) { \
            NSLog(@"%@", error); \
        } \
    } while(0)

#define IDPPrintErrorAndReturn(error, result) \
    do { \
        IDPPrintError(error); \
        \
        if (!error) { \
            return result; \
        } \
    } while(0)

#define IDPReturnNoIfError(error) \
    IDPPrintErrorAndReturn(error, NO)

#define IDPReturnNilIfError(error) \
    IDPPrintErrorAndReturn(error, nil)

#define IDPReturnVoidIfError(error) \
    IDPPrintErrorAndReturn(error, IDPEmpty)
