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
#import "NSNotificationCenter+IDPExtensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPUsersViewController *usersController = [IDPUsersViewController viewController];
    usersController.model = [IDPUserArrayModel new];
    
    window.rootViewController = usersController;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    IDPPrintMethod;
    
    [NSNotificationCenter postNotificationName:kIDPApplicationWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    IDPPrintMethod;
    
    [NSNotificationCenter postNotificationName:kIDPApplicationDidEnterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    IDPPrintMethod;
    
    [NSNotificationCenter postNotificationName:kIDPApplicationWillEnterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    IDPPrintMethod;
    
    [NSNotificationCenter postNotificationName:kIDPApplicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    IDPPrintMethod;
    
    [NSNotificationCenter postNotificationName:kIDPApplicationWillTerminate];
}

@end
