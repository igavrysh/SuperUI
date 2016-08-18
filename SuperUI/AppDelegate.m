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

#import "IDPArrayModel.h"
#import "IDPArrayObject.h"
#import "IDPImageModel.h"
#import "IDPUser.h"

#import "UIWindow+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

const NSUInteger kIDPArrayModelSampleSize = 100;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow fullScreenWindow];
    self.window = window;
    
    IDPArrayViewController *controller = [IDPArrayViewController new];
    IDPArrayModel *array = [self randomArrayModel];
    controller.array = array;
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor redColor];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (IDPArrayModel *)randomArrayModel {
    IDPArrayModel *array = [[IDPArrayModel alloc] init];
    for (NSUInteger i = 0; i < kIDPArrayModelSampleSize; i++) {
        [array addObject:[IDPUser user]];
    }

    return array;
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
