//
//  IDPFBCurrentUser.m
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBUserInteraction.h"

#import "IDPUser.h"

@interface IDPFBUserInteraction ()
@property (nonatomic, strong) FBSDKAccessToken  *token;

@end

@implementation IDPFBUserInteraction

#pragma mark -
#pragma mark Class Methods

+ (IDPUser *)userWithID:(IDPUser *)user {
    IDPFBUserInteraction *userGetter = [self new];
    
    return [userGetter userWithID:user];
}

+ (BOOL)isUserLogedIn:(IDPUser *)user {
    return (BOOL)user.ID;
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.token = [FBSDKAccessToken currentAccessToken];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (IDPUser *)userWithID:(IDPUser *)user {
    user.ID = self.token ? self.token.userID : nil;
    
    return user;
}

@end
