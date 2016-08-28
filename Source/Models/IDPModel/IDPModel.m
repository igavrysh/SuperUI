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
@property (nonatomic, strong)   id  model;

@end

@implementation IDPModel

#pragma mark -
#pragma mark IDPLoadableModel

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
        
        self.state = self.model ? IDPLoadableModelLoaded : IDPLoadableModelFailedLoading;
    });
}

- (void)fillModel {
    
}

@end
