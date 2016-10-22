//
//  DBUser.h
//  SuperUI
//
//  Created by Ievgen on 10/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "IDPObservableObject.h"
#import "IDPFBManagedObject.h"
#import "IDPCoreDataArrayModel.h"

typedef NS_ENUM(NSUInteger, IDPFBState) {
    IDPFBUserDidUnload,
    IDPFBUserDidFailLoading,
    IDPFBUserWillLoad,
    IDPFBUserDidLoadId,
    IDPFBUserDidLoadFriends,
    IDPFBUserDidLoadDetails,
    IDPFBUserStateCount
};

@class IDPFBUser;

@protocol IDPFBUserObserver <NSObject>

@optional
- (void)userDidUnload:(IDPFBUser *)user;

- (void)userDidFailLoading:(IDPFBUser *)user;

- (void)userWillLoad:(IDPFBUser *)user;

- (void)userDidLoadId:(IDPFBUser *)user;

- (void)userDidLoadDetails:(IDPFBUser *)user;

@end

@interface IDPFBUser : IDPFBManagedObject <IDPObservableObject>
@property (nonatomic, strong)   NSString        *firstName;
@property (nonatomic, strong)   NSString        *hometown;
@property (nonatomic, strong)   NSString        *lastName;
@property (nonatomic, strong)   NSString        *location;
@property (nonatomic, strong)   NSString        *name;
@property (nonatomic, strong)   NSSet           *friends;
@property (nonatomic, strong)   NSSet           *images;

//@property (nonatomic, strong)   NSManagedObject *profileImage;
//@property (nonatomic, strong)   NSSet           *images;

@end

