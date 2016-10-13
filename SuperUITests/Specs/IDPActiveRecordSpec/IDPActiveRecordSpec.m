//
//  IDPActiveRecordSpec.m
//  SuperUI
//
//  Created by Ievgen on 10/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "Kiwi.h"

#import "DBUser.h"

#import "IDPCoreDataManager.h"

#import "NSFileManager+IDPExtensions.h"
#import "NSString+IDPRandomName.h"

SPEC_BEGIN(IDPActiveRecordSpec)

NSUInteger entityCount = 10;

beforeAll(^{
    NSError *error = nil;
    
    NSString *dbPath = [[NSFileManager applicationCachePath] stringByAppendingPathComponent:@"SuperUIStore.sqlite"];
    [[NSFileManager defaultManager] removeItemAtPath:dbPath error:&error];
    
    [IDPCoreDataManager sharedManagerWithMomName:@"SuperUI"];
});

void(^createUsers)(void) = ^{
    for (NSUInteger index = 0; index < entityCount; index++) {
        DBUser *user = [DBUser new];
        
        user.firstName = [NSString randomName];
        user.lastName = [NSString randomName];
        user.hometown = [NSString randomName];
        user.location = [NSString randomName];
        user.name = [NSString randomName];
    }
};


// Check if persistent store coordinator is created with non-existent model name

SPEC_END