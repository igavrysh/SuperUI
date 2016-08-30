//
//  IDPLoadableModel.m
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLoadableModel.h"

#import "IDPGCDQueue.h"

@implementation IDPLoadableModel

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
        [self fillModel];
    });
}

- (void)fillModel {
    
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
