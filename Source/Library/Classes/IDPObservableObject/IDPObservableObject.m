//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPBlockObservationController.h"
#import "IDPMacros.h"
#import "IDPCompilerMacros.h"

#import "IDPObservableObject+IDPPrivate.h"
#import "IDPObservationController+IDPPrivate.h"

typedef void(^IDPControllerNotificationBlock)(id object);

@interface IDPObservableObject ()
@property (nonatomic, retain)   NSHashTable     *observationControllerHashTable;

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler;

- (void)performBlock:(void (^)(void))block shouldNotify:(BOOL)shouldNotify;

- (id)observationControllerWithClass:(Class)class observer:(id)observer;

@end

@implementation IDPObservableObject


#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observationControllerHashTable = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observationControllerHashTable = [NSHashTable weakObjectsHashTable];
        self.notifyObservers = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    @synchronized(self) {
        return [self.observationControllerHashTable setRepresentation];
    }
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        @synchronized(self) {
            _state = state;
            
            [self notifyOfStateChange:state];
        }
    }
}

- (void)setState:(NSUInteger)state withObject:(id)object {
    if (state != _state) {
        @synchronized(self) {
            _state = state;
            
            [self notifyOfStateChange:state withObject:object];
        }
    }
}

#pragma mark - 
#pragma mark Public

- (IDPBlockObservationController *)blockObservationControllerWithObserver:(id)observer {
    return [self observationControllerWithClass:[IDPBlockObservationController class]
                                       observer:observer];
}

- (void)performBlockWithNotification:(void (^)(void))block {
    [self performBlock:block shouldNotify:YES];
}

- (void)performBlockWithoutNotification:(void (^)(void))block {
    [self performBlock:block shouldNotify:NO];
}

#pragma mark -
#pragma mark Private

- (id)observationControllerWithClass:(Class)class observer:(id)observer {
    IDPObservationController *result = [class observationControllerWithObserver:observer
                                                               observableObject:self];
    
    @synchronized(self) {
        [self.observationControllerHashTable addObject:result];
    }
    
    return result;
}

- (void)invalidateController:(IDPObservationController *)controller {
    @synchronized(self) {
        [self.observationControllerHashTable removeObject:controller];
    }
}

- (void)performBlock:(void (^)(void))block shouldNotify:(BOOL)shouldNotify {
    BOOL state = self.shouldNotifyObservers;
    
    self.notifyObservers = shouldNotify;
    
    IDPPerformBlock(block);
    
    self.notifyObservers = state;
}


IDPClangIgnoredPerformSelectorLeaksPush

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state
                  withHandler:^(IDPObservationController *controller) {
                      [controller notifyWithState:state];
                  }];
}

- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object {
    [self notifyOfStateChange:state
                  withHandler:^(IDPObservationController *controller) {
                      [controller notifyWithState:state object:object];
                  }];
}

IDPClangIgnoredPerformSelectorLeaksPop

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler
{
    if (!handler || !self.shouldNotifyObservers) {
        return;
    }
    
    @synchronized(self) {
        NSHashTable *controllers = self.observationControllerHashTable;
        for (IDPObservationController *controller in controllers) {
            handler(controller);
        }
    }
}

@end
