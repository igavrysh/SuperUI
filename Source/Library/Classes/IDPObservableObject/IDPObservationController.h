//
//  _IDPObservationState.h
//  Test
//
//  Created by Ievgen on 6/25/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

@interface IDPObservationController : NSObject
@property (nonatomic, readonly) id                      observer;
@property (nonatomic, readonly) id                      observableObject;
@property (nonatomic, readonly, getter=isValid) BOOL    valid;

+ (instancetype)observationControllerWithObserver:(id)observer
                                 observableObject:(IDPObservableObject *)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject; // NS_DESIGNATED_INITIALIZER;

// Invalidates the object.Notifications won't be passed through it and it will
// be removed form observableObject at some point.
- (void)invalidate;

@end
