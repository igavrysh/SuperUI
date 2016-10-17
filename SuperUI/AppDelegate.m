//
//  AppDelegate.m
//  SuperUI
//
//  Created by Ievgen on 8/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AppDelegate.h"

#import "IDPUserArrayModel.h"
#import "IDPAnimationViewController.h"
#import "IDPUsersViewController.h"
#import "IDPCoreDataManager.h"

#import "UIWindow+IDPExtensions.h"
#import "NSString+IDPRandomName.h"
#import "NSNotificationCenter+IDPExtensions.h"
#import "IDPFBLoginViewController.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPMomName, @"SuperUI");

@interface AppDelegate ()
@property (nonatomic, strong)   IDPCoreDataManager  *dataManager;

@end

@implementation AppDelegate

#pragma mark -
#pragma mark Accessors

- (void)setDataManager:(IDPCoreDataManager *)dataManager {
    if (_dataManager != dataManager) {
        [_dataManager removeObserver:self];
        
        _dataManager = dataManager;
        
        [dataManager addObserverObject:self];
    }
}

#pragma mark -
#pragma mark Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    self.dataManager = [IDPCoreDataManager sharedManagerWithMomName:kIDPMomName];
    [self.dataManager setup];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
    return handled;
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
    
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    IDPPrintMethod;
}

#pragma mark -
#pragma mark IDPCoreDataManagerObserver 

- (void)coreDataManagerDidSetup:(IDPCoreDataManager *)manager {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPFBLoginViewController *fbController = [IDPFBLoginViewController new];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:fbController];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
}

@end
