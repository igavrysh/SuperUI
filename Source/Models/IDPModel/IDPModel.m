//
//  IDPModel.m
//  SuperUI
//
//  Created by Ievgen on 8/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPModel.h"

#import "IDPGCDQueue.h"

#import "NSFileManager+IDPExtensions.h"

@interface IDPModel ()

@end

@implementation IDPModel

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized(self) {
        NSUInteger state = self.state;
        
        if (IDPLoadableModelDidLoad == state || IDPLoadableModelWillLoad == state) {
            [self notifyOfStateChange:state];
            return;
        }
        
        self.state = IDPLoadableModelWillLoad;
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
        case IDPLoadableModelDidLoad:
            return @selector(modelDidLoad:);
            
        case IDPLoadableModelWillLoad:
            return @selector(modelWillLoad:);
            
        case IDPLoadableModelDidFailLoading:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
