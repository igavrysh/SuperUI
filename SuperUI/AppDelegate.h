//
//  AppDelegate.h
//  SuperUI
//
//  Created by Ievgen on 8/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPCoreDataManager.h"

@interface AppDelegate : UIResponder <
    UIApplicationDelegate,
    IDPCoreDataManagerObserver
>

@property (strong, nonatomic) UIWindow *window;


@end

