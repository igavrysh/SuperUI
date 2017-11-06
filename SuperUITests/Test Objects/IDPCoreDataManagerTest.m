//
//  IDPCoreDataManagerTest.m
//  SuperUI
//
//  Created by Ievgen on 10/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCoreDataManagerTest.h"

#import "IDPBlockMacros.h"

@implementation IDPCoreDataManagerTest

#pragma mark -
#pragma mark IDPCoreDataManagerObserver

- (void)coreDataManagerDidSetup:(IDPCoreDataManager *)manager {
    IDPPerformBlock(self.onSuccessfulSetup);
}

- (void)coreDataManagerDidFailLoading:(IDPCoreDataManager *)manager {
    IDPPerformBlock(self.onFailedSetup);
}

@end
