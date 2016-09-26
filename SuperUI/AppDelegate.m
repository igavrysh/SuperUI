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
#import "IDPFBLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPFBLoginViewController *fbController = [IDPFBLoginViewController new];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:fbController];
    
    window.rootViewController = controller;
    
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
}

@end
