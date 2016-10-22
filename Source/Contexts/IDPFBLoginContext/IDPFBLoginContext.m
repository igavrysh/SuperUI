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
#import "IDPFBUser.h"
#import "IDPFBConstants.h"

#import "IDPMacros.h"

@interface IDPFBLoginContext ()
@property (nonatomic, strong)   UIViewController    *viewController;

- (NSArray *)readPermissions;

@end

@implementation IDPFBLoginContext

@dynamic graphPath;
@dynamic requestParameters;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loginContextWithUser:(IDPFBUser *)user
                      viewController:(UIViewController *)viewController
{
    return [[self alloc] initWithUser:(IDPFBUser *)user
                       viewController:(UIViewController *)viewController];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPFBUser *)user
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
    IDPFBUser *user = (IDPFBUser *)self.model;
    
    user.managedObjectID = (NSString *)result[kIDPID];
    
    user.state = IDPFBUserDidLoadId;
    
    [user saveManagedObject];
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
        [[FBSDKLoginManager new] logInWithReadPermissions:[self readPermissions]
                                       fromViewController:self.viewController
                                                  handler:handler];
    });
}

#pragma mark -
#pragma mark Private

- (NSArray *)readPermissions {
    return @[kIDPPublicProfile,
             kIDPUserFriends,
             KIDPUserLocation];
}

@end
