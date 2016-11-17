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

- (void)setupManagedObjectModel;
- (void)setupStoreCoordinator;
- (void)setupManagedObjectContext;

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
    
    return __sharedManager;
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)setup {
    if (self.managedObjectModel && self.managedObjectContext && self.persistentStoreCoordinator) {
        return;
    }
    
    [self setupManagedObjectModel];
    [self setupStoreCoordinator];
    [self setupManagedObjectContext];
}

- (void)setupManagedObjectModel {
    NSString *modelName = self.momName;
    
    if (!modelName) {
        self.state = IDPCoreDataManagerDidFailSettingup;
        
        return;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName
                                              withExtension:@"momd"];
    if (!modelURL) {
        self.state = IDPCoreDataManagerDidFailSettingup;
        
        return;
    }
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

- (void)setupStoreCoordinator {
    NSManagedObjectModel *model = self.managedObjectModel;
    
    if (!model) {
        return;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSError *error = nil;
    
    [_persistentStoreCoordinator addPersistentStoreWithType:self.storeType
                                              configuration:nil
                                                        URL:self.storeURL
                                                    options:nil
                                                      error:&error];
    if (error) {
        self.state = IDPCoreDataManagerDidFailSettingup;
    }
}

- (void)setupManagedObjectContext {
    if (!self.persistentStoreCoordinator) {
        self.state = IDPCoreDataManagerDidFailSettingup;
        
        return;
    }
    
    NSUInteger type = NSMainQueueConcurrencyType;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    self.managedObjectContext = context;
    
    self.state = IDPCoreDataManagerDidSetup;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullStoreName {
    NSString *extension = [IDPCoreDataManager storeTypeExtensions][self.storeType];
    
    return [self.storeName stringByAppendingPathExtension:extension];
}

- (NSURL *)storeURL {
    NSURL *url = [NSURL fileURLWithPath:[NSFileManager cachePath]];
    
    return [url URLByAppendingPathComponent:[self fullStoreName]];
}


#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPCoreDataManagerDidInit:
            return @selector(coreDataManagerDidInit:);
            
        case IDPCoreDataManagerDidSetup:
            return @selector(coreDataManagerDidSetup:);
            
        case IDPCoreDataManagerDidFailSettingup:
            return @selector(coreDataManagerDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
