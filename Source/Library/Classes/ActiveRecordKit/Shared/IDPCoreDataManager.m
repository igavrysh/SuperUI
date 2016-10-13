//
//  IDPCoreDataManager.m
//  SuperUI
//
//  Created by Ievgen on 10/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCoreDataManager.h"

#import "IDPGCDQueue.h"
#import "IDPBlockTypes.h"

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
@property (nonatomic, readonly) NSString                        *fullStoreName;
@property (nonatomic, readonly) NSURL                           *storeURL;

@end

@implementation IDPCoreDataManager

@dynamic fullStoreName;
@dynamic storeURL;

#pragma mark -
#pragma mark Class Methods

+ (NSDictionary *)storeTypeExtensions {
    IDPReturnAfterSettingVariableWithBlockOnce(^{
        return @{ NSSQLiteStoreType : @"sqllite" };
    });
}

+ (instancetype)sharedManager {
    return __sharedManager;
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName {
    return [self sharedManagerWithMomName:momName
                                storeName:kDefaultStoreName];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
{
    return [self sharedManagerWithMomName:momName
                                storeName:storeName
                                storeType:NSSQLiteStoreType];
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
    
    
    [__sharedManager initStoreCoordinator];
    
    return __sharedManager;
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)setUp {
    if (__sharedManager) {
        return;
    }
    
    IDPWeakify(self);
    [self setUpManagedObjectModelWithCompletionHandler:^{
        IDPStrongify(self);
        [self setUpStoreCoordinatorWithCompletionHandler:^{
            IDPStrongify(self);
            [self setUpManagedObjectContextWithCompletionHandler:nil];
        }];
    }];
}

- (void)setUpManagedObjectModelWithCompletionHandler:(IDPVoidBlock)block {
    NSString *modelName = self.momName;
    
    if (!modelName) {
        self.state = IDPCoreDataManagerDidFailSettingUp;
        
        return;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName
                                              withExtension:@"momd"];
    if (!modelURL) {
        self.state = IDPCoreDataManagerDidFailSettingUp;
        
        return;
    }
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    IDPPerformBlock(block);
}

- (void)setUpStoreCoordinatorWithCompletionHandler:(IDPVoidBlock)block {
    void (^coordinatorFactory)(void) = ^{
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error = nil;
        
        [_persistentStoreCoordinator addPersistentStoreWithType:self.storeType
                                                  configuration:nil
                                                            URL:self.storeURL
                                                        options:nil
                                                          error:&error];
        if (error) {
            self.state = IDPCoreDataManagerDidSetUp;
            
            return;
        }
        
        IDPBlockPerform(block);
    };
    
    IDPAsyncPerformInQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, coordinatorFactory);
}

- (void)setUpManagedObjectContextWithCompletionHandler:(IDPVoidBlock)block {
    if (!self.persistentStoreCoordinator) {
        NSLog(@"Error: Persistent Store Coordinator was not initialized, call -initStoreCoordinator");
        
        return;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    self.state =  IDPCoreDataManagerDidSetUp;
    
    IDPPerformBlock(block);
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullStoreName {
    NSString *extension = [IDPCoreDataManager storeTypeExtensions][self.storeType];
    
    return [self.storeName stringByAppendingPathExtension:extension];
}

- (NSURL *)storeURL {
    NSURL *url = [NSURL fileURLWithPath:[NSFileManager documentPath]];
    
    return [url URLByAppendingPathComponent:[self fullStoreName]];
}

@end
