//
//  IDPUser.h
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDPUser : NSObject
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *surname;
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, readonly) UIImage     *image;

@end
