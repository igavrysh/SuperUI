//
//  AppDelegate.m
//  SuperUI
//
//  Created by Ievgen on 8/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "AppDelegate.h"

#import "IDPAnimationViewController.h"
#import "IDPArrayViewController.h"

#import "UIWindow+IDPFullScreenWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPAnimationViewController *controller = [IDPAnimationViewController new];
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor greenColor];
    
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
