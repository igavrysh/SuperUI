//
//  IDPDeleteContext.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBDeleteContext.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPHTTPMethodDelete, @"DELETE");

@implementation IDPFBDeleteContext

#pragma mark -
#pragma mark Public Methods

- (NSString *)httpMethod {
    return kIDPHTTPMethodDelete;
}

@end
