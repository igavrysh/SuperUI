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

#import "IDPFBUser.h"

@interface IDPFBUserInteraction ()
@property (nonatomic, strong) FBSDKAccessToken  *token;

@end

@implementation IDPFBUserInteraction

#pragma mark -
#pragma mark Class Methods

+ (IDPFBUser *)userWithID:(IDPFBUser *)user {
    IDPFBUserInteraction *userGetter = [self new];
    
    return [userGetter userWithID:user];
}

+ (BOOL)isUserLoggedIn:(IDPFBUser *)user {
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

- (IDPFBUser *)userWithID:(IDPFBUser *)user {
    user.ID = self.token ? self.token.userID : nil;
    
    return user;
}

@end
