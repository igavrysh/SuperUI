//
//  IDPObservableObject.h
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPBlockObservationController;

@interface IDPObservableObject : NSObject
@property (nonatomic, assign) NSUInteger  state;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (IDPBlockObservationController *)blockObservationControllerWithObserver:(id)observer;

// these methods are called in sublcasses
// you should never call this methods dirctly from outside subclasses
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

@end
