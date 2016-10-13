//
//  DBUser+CoreDataProperties.h
//  SuperUI
//
//  Created by Ievgen on 10/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DBUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fbGUID;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *hometown;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) DBUser *friends;
@property (nullable, nonatomic, retain) NSManagedObject *images;
@property (nullable, nonatomic, retain) NSManagedObject *profileImage;

@end

NS_ASSUME_NONNULL_END
