//
//  IDPGetContext.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBGetContext.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPHTTPMethodGet, @"GET");

@implementation IDPFBGetContext

#pragma mark -
#pragma mark Public Methods

- (NSString *)httpMethod {
    return kIDPHTTPMethodGet;
}

@end
