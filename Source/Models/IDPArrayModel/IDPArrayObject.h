//
//  IDPArrayItem.h
//  SuperUI
//
//  Created by Ievgen on 8/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IDPImageModel;

@interface IDPArrayObject : NSObject
@property (nonatomic, readonly) NSString        *name;
@property (nonatomic, readonly) IDPImageModel   *imageModel;

+ (instancetype)objectWithName:(NSString *)name url:(NSURL *)url;

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url;

- (void)save;
- (void)load;

@end
