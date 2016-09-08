//
//  NSNotificationCenter+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/7/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSNotificationCenter+IDPExtensions.h"

#import "NSArray+IDPArrayEnumerator.h"

@implementation NSNotificationCenter (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (void)postNotificationName:(NSString *)notificationName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

+ (void)addObserver:(id)observer selector:(SEL)selector names:(NSArray *)names {
    [names performBlockWithEachObject:^(NSString *name) {
        [self addObserver:observer selector:selector name:name];
    }];
}

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:kIDPApplicationWillTerminate
                                               object:nil];
}

@end
