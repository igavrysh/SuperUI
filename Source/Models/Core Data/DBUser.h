//
//  DBUser.h
//  SuperUI
//
//  Created by Ievgen on 10/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBUser : NSManagedObject
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

