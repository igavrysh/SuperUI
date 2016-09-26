//
//  IDPFBLoginContext.m
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBLoginContext.h"


#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface IDPFBLoginContext ()
@property (nonatomic, strong) UIViewController *viewController;

@end


@implementation IDPFBLoginContext

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loginContextWithViewController:(UIViewController *)viewController {
    return [[self alloc] initWithViewController:viewController];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    self.viewController = viewController;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    id handler = ^void(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Logged in");
        }
    };

    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"]
                 fromViewController:self.viewController
                            handler:handler];
    
}

@end
