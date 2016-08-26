//
//  AppDelegate.m
//  SuperUI
//
//  Created by Ievgen on 8/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "AppDelegate.h"

#import "IDPAnimationViewController.h"
#import "IDPUsersViewController.h"

#import "IDPUserArrayModel.h"

#import "UIWindow+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPArrayViewController *controller = [IDPUsersViewController viewController];
    controller.arrayModel = [IDPUserArrayModel new];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
