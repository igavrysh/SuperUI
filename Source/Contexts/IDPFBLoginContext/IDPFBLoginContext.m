//
//  IDPFBLoginContext.m
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBLoginContext.h"

#import "IDPGCDQueue.h"
#import "IDPUser.h"

#import "IDPMacros.h"

@interface IDPFBLoginContext ()
@property (nonatomic, strong) IDPUser           *user;

@end

@implementation IDPFBLoginContext

@dynamic graphPath;
@dynamic requestParameters;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loginContextWithUser:(IDPUser *)user {
    return [[self alloc] initWithUser:(IDPUser *)user];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user {
    self = [super init];
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return kIDPMe;
}

- (NSDictionary *)requestParameters {
    return @{
             kIDPFields: kIDPId
             };
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    IDPUser *user = self.user;
    
    user.Id = (NSString *)result[kIDPId];
    user.state = user.state | IDPUserDidLoadId;
}

@end
