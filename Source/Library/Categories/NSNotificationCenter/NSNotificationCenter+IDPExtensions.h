//
//  NSNotificationCenter+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 9/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMacros.h"

kIDPStringKeyDefinition(kIDPApplicationWillResignActive);
kIDPStringKeyDefinition(kIDPApplicationDidEnterBackground);
kIDPStringKeyDefinition(kIDPApplicationWillEnterForeground);
kIDPStringKeyDefinition(kIDPApplicationDidBecomeActive);
kIDPStringKeyDefinition(kIDPApplicationWillTerminate);

@interface NSNotificationCenter (IDPExtensions)

+ (void)postNotificationName:(NSString *)notificationName;

+ (void)addObserver:(id)observer selector:(SEL)selector names:(NSArray *)names;

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name;

@end
