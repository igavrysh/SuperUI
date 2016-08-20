//
//  IDPArrayView.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayView.h"

#import "IDPMacro.h"
#import "IDPArrayModel.h"
#import "IDPBlockObservationController.h"

@interface IDPArrayView ()
@property (nonatomic, strong)   IDPArrayModel   *data;
@property (nonatomic, strong)   IDPBlockObservationController   *observer;

- (void)prepareObserver:(IDPBlockObservationController *)observer;

@end


@implementation IDPArrayView

#pragma mark -
#pragma mark Accessors

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark - 
#pragma mark Private Methods

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self);
    
    id handler = ^(IDPBlockObservationController *controller, id userInfo) {
        
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"ddd");
        /*
        void(^block)(void) = ^ {
            IDPStrongifyAndReturnIfNil(self);
            
            IDPArrayModel *model = controller.observableObject;
            self.contentImageView.image = model.image;
        };
        
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
         */
    };
    
    [observer setHandler:handler forState:IDPArrayModelUpdated];
}

@end
