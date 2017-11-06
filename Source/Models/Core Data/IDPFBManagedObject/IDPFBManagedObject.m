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

+ (instancetype)managedObjectWithID:(NSString *)managedObjectID {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"managedObjectID == %@", managedObjectID];
    
    IDPFBManagedObject *object = [[self fetchEntityWithPredicate:predicate sortDescriptors:nil] firstObject];
    
    if (!object) {
        object = [self managedObject];
        
        object.managedObjectID = managedObjectID;
    }
    
    return object;
}

@end
