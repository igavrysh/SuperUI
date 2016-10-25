//
//  IDPObservableObject.h
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPObservableObject <NSObject>

@optional
@property (nonatomic, assign)   NSUInteger      state;

- (SEL)selectorForState:(NSUInteger)state;

@end

@interface IDPObservableObject : NSObject <IDPObservableObject>
@property (nonatomic, assign)   NSUInteger      state;
@property (nonatomic, readonly) NSSet           *observerSet;

- (instancetype)initWithTarget:(id)target;

- (void)addObserverObjects:(NSArray *)observers;
- (void)addObserverObject:(id)observer;

- (void)removeObserverObjects:(NSArray *)observers;
- (void)removeObserverObject:(id)observer;

- (BOOL)isObservedByObject:(id)observer;

- (SEL)selectorForState:(NSUInteger)state;

- (void)setState:(NSUInteger)state object:(id)object;

- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

- (void)performBlockWithNotification:(void (^)(void))block;
- (void)performBlockWithoutNotification:(void (^)(void))block;

@end
