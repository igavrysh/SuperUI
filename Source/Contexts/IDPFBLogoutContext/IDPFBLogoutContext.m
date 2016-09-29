//
//  IDPFBLogoutContext.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBLogoutContext.h"

#import "IDPUser.h"

#import "IDPFBConstants.h"

@implementation IDPFBLogoutContext

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPUser *user = (IDPUser *)self.model;
    
    return [NSString stringWithFormat:@"%@/%@", user.ID, kIDPPermissions];
}

- (NSDictionary *)requestParameters {
    return nil;
}

#pragma mark -
#pragma mar Public Methods

- (void)load {
    [super load];
    
    [[FBSDKLoginManager new] logOut];
}

@end
