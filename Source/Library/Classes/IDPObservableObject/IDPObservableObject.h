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

- (void)addObserverObjects:(NSArray *)observers;
- (void)addObserverObject:(id)observer;

- (void)removeObserverObjects:(NSArray *)observers;
- (void)removeObserverObject:(id)observer;

@end

@interface IDPObservableObject : NSObject <IDPObservableObject>
@property (nonatomic, assign)           NSUInteger              state;
@property (nonatomic, readonly)         NSSet                   *observerSet;
@property (nonatomic, weak, readonly)   id<IDPObservableObject> target;

- (instancetype)initWithTarget:(id)target;

- (BOOL)isObservedByObject:(id)observer;

- (SEL)selectorForState:(NSUInteger)state;

- (void)setState:(NSUInteger)state object:(id)object;

- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

- (void)performBlockWithNotification:(void (^)(void))block;
- (void)performBlockWithoutNotification:(void (^)(void))block;

@end
