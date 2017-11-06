//
//  IDPActiveRecordSpec.m
//  SuperUI
//
//  Created by Ievgen on 10/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "IDPFBUser.h"

#import "IDPCoreDataManager.h"
#import "IDPActiveRecordKit.h"
#import "IDPCoreDataManagerTest.h"

#import "NSFileManager+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

SPEC_BEGIN(IDPActiveRecordSpec)

NSUInteger entityCount = 10;
NSString *storeName = @"SuperUIStore";


beforeAll(^{
    NSError *error = nil;
    
    NSString *storeFullName = [storeName stringByAppendingPathExtension:@"sqllite"];
    
    NSString *dbPath = [[NSFileManager cachePath] stringByAppendingPathComponent:storeFullName];
    
    [[NSFileManager defaultManager] removeItemAtPath:dbPath error:&error];
    
    [IDPCoreDataManager sharedManagerWithMomName:@"SuperUI" storeName:storeName];
    
    __block BOOL successfulSetup = NO;
    __block BOOL failedSetup = NO;
    IDPCoreDataManagerTest *coreDataManagerObserver = [IDPCoreDataManagerTest new];
    coreDataManagerObserver.onSuccessfulSetup = ^{
        successfulSetup = YES;
    };
    
    coreDataManagerObserver.onFailedSetup = ^{
        failedSetup = YES;
    };
    
    [[IDPCoreDataManager sharedManager] addObserverObject:coreDataManagerObserver];
    
    [[IDPCoreDataManager sharedManager] setup];
    
    while (!successfulSetup && !failedSetup) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
});


void(^createUsers)(void) = ^{
    for (NSUInteger index = 0; index < entityCount; index++) {
        IDPFBUser *user = [IDPFBUser managedObject];
        
        user.firstName = [NSString randomName];
        user.lastName = [NSString randomName];
        user.hometown = [NSString randomName];
        user.location = [NSString randomName];
        user.name = [NSString randomName];
    }
};

__block NSManagedObjectContext *currentContext = nil;

NSArray *(^fetchUsersFromCustomContext)(void) = ^{
    if (!currentContext) {
        currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        currentContext.persistentStoreCoordinator = [[IDPCoreDataManager sharedManager] persistentStoreCoordinator];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([IDPFBUser class])];
    request.returnsObjectsAsFaults = YES;
    
    NSError *error = nil;
    
    return [currentContext executeFetchRequest:request error:&error];
};

describe(@"DBUser", ^{
    context(@"when inserted into NSManagedObjectContext", ^{
        beforeAll(^{
            createUsers();
        });
        
        it(@"users should be present in current context", ^{
            NSArray *users = [IDPFBUser fetchEntityWithPredicate:nil sortDescriptors:nil];
            
            [[users should] haveCountOf:entityCount];
        });
        
        it(@"users shouldn't be present in custom context", ^{
            NSArray *users = fetchUsersFromCustomContext();
            [[users should] haveCountOf:0];
        });
        
        context(@"after saving current context", ^{
            beforeAll(^{
                [NSManagedObjectContext saveManagedObjectContext];
            });
            
            it(@"10 users should be present in custom context", ^{
                NSArray *users = fetchUsersFromCustomContext();
                [[users should] haveCountOf:10];
            });
        });
    });
});

// Check if persistent store coordinator is created with non-existent model name

SPEC_END