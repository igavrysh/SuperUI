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
    IDPUserDidLoadId                    = IDPModelStateCount << 1,
    IDPUserDidLoadBasicInformation      = IDPModelStateCount << 2,
    IDPUserDidLoadDetails               = IDPModelStateCount << 3,
    IDPUserStateCount
};

@protocol IDPUserStateObserver <NSObject, IDPModelObserver>

@optional

- (void)userDidLoadId:(IDPUser *)user;

- (void)userDidLoadBasicInformation:(IDPUser *)user;

- (void)userDidLoadDetails:(IDPUser *)user;

@end

@class IDPImageModel;

@interface IDPUser : IDPModel <NSCopying, NSCoding>
@property (nonatomic, copy)     NSString        *Id;
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, copy)     NSString        *surname;
@property (nonatomic, readonly) NSString        *fullName;

@property (nonatomic, copy)     NSURL           *imageURL;
@property (nonatomic, readonly) IDPImageModel   *imageModel;

+ (instancetype)user;
+ (NSArray *)usersWithCount:(NSUInteger)count;

@end
