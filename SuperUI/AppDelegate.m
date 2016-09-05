//
//  AppDelegate.m
//  SuperUI
//
//  Created by Ievgen on 8/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "AppDelegate.h"

#import "IDPUserArrayModel.h"
#import "IDPAnimationViewController.h"
#import "IDPUsersViewController.h"

#import "UIWindow+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

#import "IDPMacros.h"

@interface AppDelegate ()
@property (nonatomic, strong) IDPUsersViewController *usersController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    self.usersController = [IDPUsersViewController viewController];
    self.usersController.model = [IDPUserArrayModel new];
    
    //IDPAnimationViewController *controller = [IDPAnimationViewController viewController];
    
    window.rootViewController = self.usersController;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    IDPPrintMethod;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    IDPPrintMethod;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    IDPPrintMethod;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    IDPPrintMethod;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    IDPPrintMethod;
    
    [(IDPArrayModel *)self.usersController.model save];
}

@end
