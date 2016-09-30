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
#import "IDPFBConstants.h"

#import "IDPMacros.h"

@interface IDPFBLoginContext ()
@property (nonatomic, strong)   UIViewController    *viewController;

@end

@implementation IDPFBLoginContext

@dynamic graphPath;
@dynamic requestParameters;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loginContextWithUser:(IDPUser *)user
                      viewController:(UIViewController *)viewController
{
    return [[self alloc] initWithUser:(IDPUser *)user
                       viewController:(UIViewController *)viewController];
}

+ (IDPUser *)user {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    
    if (!token) {
        return nil;
    }
    
    IDPUser *user = [IDPUser new];
    user.ID = token.userID;
    
    return user;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user
              viewController:(UIViewController *)viewController
{
    self = [super initWithModel:user];
    self.viewController = viewController;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return kIDPMe;
}

- (NSDictionary *)requestParameters {
    return @{
             kIDPFields: kIDPID
             };
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    IDPUser *user = (IDPUser *)self.model;
    
    user.ID = (NSString *)result[kIDPID];
    user.state = IDPUserDidLoadID;
}

- (void)load {
    id handler = ^void(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            [super load];
        }
    };
    
    IDPAsyncPerformInMainQueue(^{
        [[FBSDKLoginManager new] logInWithReadPermissions: @[kIDPPublicProfile, kIDPUserFriends]
                                       fromViewController:self.viewController
                                                  handler:handler];
    });
}

@end
