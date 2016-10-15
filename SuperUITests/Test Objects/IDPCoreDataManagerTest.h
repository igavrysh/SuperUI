//
//  IDPCoreDataManagerTest.h
//  SuperUI
//
//  Created by Ievgen on 10/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPActiveRecordKit.h"

#import "IDPBlockTypes.h"

@interface IDPCoreDataManagerTest : NSObject <IDPCoreDataManagerObserver>
@property (nonatomic, strong) IDPVoidBlock onSuccessfulSetUp;
@property (nonatomic, strong) IDPVoidBlock onFailedSetUp;


@end
