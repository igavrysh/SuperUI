//
//  IDPBlockObservationController.h
//  Test
//
//  Created by Ievgen on 6/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservationController.h"

typedef void(^IDPStateChangeHandler)(IDPBlockObservationController *controller, id userInfo);

@interface IDPBlockObservationController : IDPObservationController

- (void)setHandler:(IDPStateChangeHandler)handler
          forState:(NSUInteger)state;

- (void)removeHandlerForState:(NSUInteger)state;

- (IDPStateChangeHandler)handlerForState:(NSUInteger)state;

- (BOOL)containsHandlerForState:(NSUInteger)state;

// states require termination with -1 or NSUintegerMax
- (void)setHandler:(IDPStateChangeHandler)handler
          forStates:(NSUInteger)state, ...;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;


@end
