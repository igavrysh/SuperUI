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

typedef NS_ENUM(NSUInteger, IDPCoreDataManagerState) {
    IDPCoreDataManagerDidSetUp,
    IDPCoreDataManagerDidFailSettingUp,
    IDPPersistentStoreCoordinatorStateCount
};

@class IDPCoreDataManager;

@protocol IDPCoreDataManagerObserver <NSObject>
@optional

- (void)coreDataManagerDidSetUp:(IDPCoreDataManager *)manager;

- (void)coreDataManagerDidFaileLoading:(IDPCoreDataManager *)manager;

@end

@interface IDPCoreDataManager : IDPObservableObject
@property (nonatomic, readonly) NSManagedObjectModel            *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator    *persistentStoreCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext          *managedObjectContext;

+ (instancetype)sharedManager;

+ (instancetype)sharedManagerWithMomName:(NSString *)momName;

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName;

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
                               storeType:(NSString *)storeType;

+ (NSDictionary *)storeTypeExtensions;

// Always call -initStoreCoordinator befor +sharedManager usage
- (void)initStoreCoordinator;

@end
