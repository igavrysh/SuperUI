//
//  IDPFBGetGraphRequest.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBGetGraphRequest.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPHTTPMethodGet, @"GET");

@implementation IDPFBGetGraphRequest

#pragma mark -
#pragma mark Class Methods

+ (instancetype)requestWithGraphPath:(NSString *)graphPath
                          parameters:(NSDictionary *)requestParameters
{
    return [[self alloc] initWithGraphPath:graphPath
                                parameters:requestParameters];
}


#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithGraphPath:(NSString *)graphPath
                       parameters:(NSDictionary *)requestParameters
{
    self = [super initWithGraphPath:graphPath parameters:requestParameters HTTPMethod:kIDPHTTPMethodGet];
    
    return self;
}

@end
