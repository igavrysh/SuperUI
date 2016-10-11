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
@class IDPArrayModel;

@class IDPImageModel;

@interface IDPUser : IDPModel
@property (nonatomic, copy)     NSString        *ID;
@property (nonatomic, copy)     NSString        *firstName;
@property (nonatomic, copy)     NSString        *lastName;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, copy)     NSString        *location;
@property (nonatomic, copy)     NSString        *hometown;
@property (nonatomic, readonly) IDPArrayModel   *friends;

@property (nonatomic, copy)     NSURL           *imageURL;
@property (nonatomic, readonly) IDPImageModel   *imageModel;

@property (nonatomic, copy)     NSURL           *bigImageURL;
@property (nonatomic, readonly) IDPImageModel   *bigImageModel;

@property (nonatomic, readonly) NSString        *plistName;
@property (nonatomic, readonly) NSString        *cachePath;
@property (nonatomic, readonly, getter=isCacheExists) BOOL cacheExists;

+ (instancetype)user;
+ (instancetype)userWithID:(NSString *)ID;

- (instancetype)initWithID:(NSString *)ID;

+ (NSArray *)usersWithCount:(NSUInteger)count;

- (void)save;

@end
