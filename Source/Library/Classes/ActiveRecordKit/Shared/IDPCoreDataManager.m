//
//  IDPCoreDataManager.m
//  SuperUI
//
//  Created by Ievgen on 10/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCoreDataManager.h"

#import "IDPGCDQueue.h"

#import "NSFileManager+IDPExtensions.h"

#import "IDPDispatchMacros.h"

static IDPCoreDataManager *__sharedManager = nil;

kIDPStringVariableDefinition(kDefaultStoreName, @"Store");

@interface IDPCoreDataManager ()
@property (nonatomic, strong)   NSManagedObjectModel            *managedObjectModel;
@property (nonatomic, strong)   NSPersistentStoreCoordinator    *persistentStoreCoordinator;
@property (nonatomic, strong)   NSManagedObjectContext          *managedObjectContext;
@property (nonatomic, copy)     NSString                        *momName;
@property (nonatomic, copy)     NSString                        *storeName;
@property (nonatomic, copy)     NSString                        *storeType;

@end

@implementation IDPCoreDataManager

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedManager {
    return __sharedManager;
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName {
    return [self sharedManagerWithMomName:momName storeName:kDefaultStoreName];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
{
    return [self sharedManagerWithMomName:momName
                                storeName:storeName
                                storeType:nil];
}



+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
                               storeType:(NSString *)storeType
{
    if (__sharedManager) {
        return __sharedManager;
    }
    
    __sharedManager = [self new];
    __sharedManager.momName = momName;
    __sharedManager.storeName = storeName;
    __sharedManager.storeType = storeType;
    
    #warning TEMP decision
    [__sharedManager initStoreCoordinator];
    
    return __sharedManager;
}

+ (NSDictionary *)storeTypeExtensions {
    IDPReturnAfterSettingVariableWithBlockOnce(^{
        return @{ NSSQLiteStoreType : @"sqllite" };
    });
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)initStoreCoordinator {
    void (^coordinatorFactory)(void) = ^{
        NSString *extension = [IDPCoreDataManager storeTypeExtensions][self.storeType];
        NSString *storeName = [self.storeName stringByAppendingPathExtension:extension];
        
        NSURL *storeURL = [NSURL fileURLWithPath:[NSFileManager documentPath]];
        storeURL = [storeURL URLByAppendingPathComponent:storeName];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        if (!_persistentStoreCoordinator) {
            NSLog(@"Error: during store corrdinator init failed to init with managed object");
            
            return;
        }
        
        NSString *storeType = self.storeType;
        self.storeType = storeType ? storeType : NSSQLiteStoreType;
        
        NSError *error = nil;
        
        [_persistentStoreCoordinator addPersistentStoreWithType:storeType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        }
        
    };
    
    IDPAsyncPerformInQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, coordinatorFactory);
}

#pragma mark -
#pragma mark Accessors

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSString *modelName = self.momName;
    
    if (!modelName) {
        return nil;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName
                                              withExtension:@"momd"];
    
    if (!modelURL) {
        return nil;
    }
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    if (!self.persistentStoreCoordinator) {
        NSLog(@"Error: Persistent Store Coordinator was not initialized, call -initStoreCoordinator");
        
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return _managedObjectContext;
}

@end
