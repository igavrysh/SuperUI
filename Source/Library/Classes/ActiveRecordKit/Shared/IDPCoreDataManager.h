//
//  IDPCoreDataManager.h
//  SuperUI
//
//  Created by Ievgen on 10/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "IDPObservableObject.h"

@class IDPCoreDataManager;

@interface IDPCoreDataManager : NSObject

+ (instancetype)sharedManager;
+ (NSDictionary *)storeTypeExtensions;

// Always call -initStoreCoordinator befor +sharedManager usage
- (void)initStoreCoordinator;

@end
