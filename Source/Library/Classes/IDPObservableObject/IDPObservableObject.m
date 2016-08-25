//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPMacros.h"
#import "IDPCompilerMacros.h"

#import "NSArray+IDPArrayEnumerator.h"

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable   *observers;
@property (nonatomic, assign) BOOL          notifyObservers;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;
- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object;

- (void)performBlock:(void (^)(void))block
        shouldNotify:(BOOL)shouldNotify;

@end

@implementation IDPObservableObject

@dynamic observerSet;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observers = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observers = [NSHashTable weakObjectsHashTable];
        self.notifyObservers = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    @synchronized(self.observers) {
        return [self.observers setRepresentation];
    }
}

- (void)setState:(NSUInteger)state {
    [self setState:state object:nil];
}

- (void)setState:(NSUInteger)state object:(id)object {
    @synchronized(self) {
        if (state != _state) {
            _state = state;
            
            [self notifyOfStateChange:_state withObject:object];
        }
    }
}

#pragma mark - 
#pragma mark Public

- (void)addObservers:(NSArray *)observers {
    @synchronized(self.observers) {
        [observers performBlockWithEachObject:^(id object) {
            [self addObserver:object];
        }];
    }
}

- (void)addObserver:(id)observer {
    @synchronized(self.observers) {
        if (![self.observers containsObject:observer]) {
            [self.observers addObject:observer];
        }
    }
}

- (void)removeObservers:(NSArray *)observers {
    @synchronized(self.observers) {
        [observers performBlockWithEachObject:^(id object) {
            [self removeObserver:object];
        }];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized(self.observers) {
        [self.observers removeObject:observer];
    }
}

- (BOOL)isObservedByObject:(id)observer {
    @synchronized(self.observers) {
        return [self.observers containsObject:observer];
    }
}

- (void)performBlockWithoutNotification:(void (^)(void))block {
    [self performBlock:block shouldNotify:NO];
}

- (void)performBlockWithNotification:(void (^)(void))block {
    [self performBlock:block shouldNotify:YES];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    return nil;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector object:nil];
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state withObject:nil];
}

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    [self notifyOfStateChangeWithSelector:[self selectorForState:state] object:object];
}

IDPClangIgnoredPerformSelectorLeaksPush

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object {
    if (!self.notifyObservers) {
        return;
    }
    
    @synchronized(self.observers) {
        NSHashTable *observers = self.observers;
        for (id object in observers) {
            if ([object respondsToSelector:selector]) {
                [object performSelector:selector withObject:self withObject:object];
            }
        }
    }
}

IDPClangIgnoredPerformSelectorLeaksPop

- (void)performBlock:(void (^)(void))block
        shouldNotify:(BOOL)shouldNotify
{
    BOOL state = self.notifyObservers;
    
    self.notifyObservers = shouldNotify;
    
    IDPPerformBlock(block);
    
    self.notifyObservers = state;
}

@end
