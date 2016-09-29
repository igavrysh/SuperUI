//
//  IDPUser.h
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "IDPModel.h"

@class IDPUser;

typedef NS_ENUM(NSUInteger, IDPUserState) {
    IDPUserDidLoadID = IDPModelStateCount,
    IDPUserDidLoadBasicInformation,
    IDPUserDidLoadDetails,
    IDPUserStateCount
};

@protocol IDPUserStateObserver <NSObject, IDPModelObserver>

@optional

- (void)userDidLoadID:(IDPUser *)user;

- (void)userDidLoadBasicInformation:(IDPUser *)user;

- (void)userDidLoadDetails:(IDPUser *)user;

@end

@class IDPImageModel;

@interface IDPUser : IDPModel <NSCopying, NSCoding>
@property (nonatomic, copy)     NSString        *ID;
@property (nonatomic, copy)     NSString        *firstName;
@property (nonatomic, copy)     NSString        *lastName;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, copy)     NSString        *location;
@property (nonatomic, copy)     NSString        *hometown;

@property (nonatomic, copy)     NSURL           *imageURL;
@property (nonatomic, readonly) IDPImageModel   *imageModel;

@property (nonatomic, copy)     NSURL           *bigImageURL;
@property (nonatomic, readonly) IDPImageModel   *bigImageModel;

+ (instancetype)user;
+ (NSArray *)usersWithCount:(NSUInteger)count;

@end
