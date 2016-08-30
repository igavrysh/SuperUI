//
//  IDPModel.m
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPModel.h"

#import "IDPGCDQueue.h"

@interface IDPModel ()

@end

@implementation IDPModel

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized(self) {
        NSUInteger state = self.state;
        
        if (IDPLoadableModelLoaded == state || IDPLoadableModelLoading == state) {
            [self notifyOfStateChange:state];
            return;
        }
        
        self.state = IDPLoadableModelLoading;
    }
    
    IDPAsyncPerformInBackgroundQueue(^{
        [self performLoading];
    });
}

- (void)performLoading {
    
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPLoadableModelLoaded:
            return @selector(modelDidLoad:);
            
        case IDPLoadableModelLoading:
            return @selector(modelWillLoad:);
            
        case IDPLoadableModelFailedLoading:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
