//
//  IDPFBManagedObject.h
//  SuperUI
//
//  Created by Ievgen on 10/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "IDPObservableObject.h"

#import "NSManagedObject+IDPExtensions.h"

@interface IDPFBManagedObject : NSManagedObject
@property (nonatomic, strong)   NSString    *managedObjectID;

+ (instancetype)objectWithID:(NSString *)objectID;

@end
