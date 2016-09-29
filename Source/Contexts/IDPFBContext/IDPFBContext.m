//
//  IDPFBContext.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBContext.h"
#import "IDPJSONAdapter.h"

#include "IDPModel.h"

@implementation IDPFBContext

@dynamic graphPath;
@dynamic requestParameters;

#pragma mark - 
#pragma mark Accessors

- (NSString *)graphPath {
    return nil;
}

- (NSDictionary *)requestParameters {
    return nil;
}

#pragma mark -
#pragma mark Public

- (void)load {
    if ([FBSDKAccessToken currentAccessToken]) {
        id handler = ^(FBSDKGraphRequestConnection *connection, id<IDPJSONAdapter> result, NSError *error) {
            if (!error) {
                [self fillWithResult:[result JSONRepresentation]];
            } else {
                self.model.state = IDPModelDidFailLoading;
            }
        };
        
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.graphPath
                                                                       parameters:self.requestParameters
                                                                       HTTPMethod:self.httpMethod];
        [request startWithCompletionHandler:handler];
    }
}

- (void)fillWithResult:(id)result {
}

- (NSString *)httpMethod {
    return nil;
}

@end

