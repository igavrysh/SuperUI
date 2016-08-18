//
//  IDPUser.h
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IDPImageModel;

@interface IDPUser : NSObject
@property (nonatomic, copy)     NSString        *name;
@property (nonatomic, copy)     NSString        *surname;
@property (nonatomic, readonly) NSString        *fullName;

@property (nonatomic, copy)     NSURL           *imageURL;
@property (nonatomic, readonly) IDPImageModel   *imageModel;

+ (instancetype)user;

+ (instancetype)userWithName:(NSString *)name
                     surname:(NSString *)surname
                         url:(NSURL *)imageURL;

- (instancetype)initWithName:(NSString *)name
                     surname:(NSString *)surname
                         url:(NSURL *)imageUrl;

@end
