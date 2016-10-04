//
//  DCIModel.m
//  SuperUI
//
//  Created by Ievgen on 10/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "DCIModel.h"

@implementation DCIModel

#pragma mark -
#pragma mark Public Methods

- (void)save {
}

- (void)load {
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case DCIModelDidUnload:
            return @selector(modelDidUnload:);
            
        case DCIModelDidLoad:
            return @selector(modelDidLoad:);
            
        case DCIModelWillLoad:
            return @selector(modelWillLoad:);
            
        case DCIModelDidFailLoading:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}


@end
