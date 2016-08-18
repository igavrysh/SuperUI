//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "IDPBlockObservationController.h"

#import "IDPObservableObject+IDPPrivate.h"
#import "IDPObservationController+IDPPrivate.h"

typedef void(^IDPControllerNotificationBlock)(id object);

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable   *observationControllerHashTable;

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler;

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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

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

#pragma clang diagnostic pop

- (void)notifyOfStateChange:(NSUInteger)state
                withHandler:(IDPControllerNotificationBlock)handler
{
    if (!handler) {
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
