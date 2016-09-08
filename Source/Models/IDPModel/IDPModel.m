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
        
        if (IDPModelDidLoad == state || IDPModelWillLoad == state) {
            [self notifyOfStateChange:state];
            return;
        }
        
        self.state = IDPModelWillLoad;
    }
    
    IDPAsyncPerformInBackgroundQueue(^{
        [self performLoading];
    });
}

- (void)performLoading {
    self.state = IDPModelDidLoad;
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPModelDidLoad:
            return @selector(modelDidLoad:);
            
        case IDPModelWillLoad:
            return @selector(modelWillLoad:);
            
        case IDPModelDidFailLoading:
            return @selector(modelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
