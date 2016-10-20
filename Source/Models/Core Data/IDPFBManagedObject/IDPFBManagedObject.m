//
//  IDPFBManagedObject.m
//  SuperUI
//
//  Created by Ievgen on 10/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBManagedObject.h"


@implementation IDPFBManagedObject

@dynamic managedObjectID;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithID:(NSString *)objectID {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^(IDPFBManagedObject *object, NSDictionary<NSString *,id> * _Nullable bindings) {
        return object.managedObjectID == objectID;
    }]
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    
}

@end
