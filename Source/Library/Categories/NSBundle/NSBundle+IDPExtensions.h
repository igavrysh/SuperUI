//
//  NSBundle+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (IDPExtensions)

+ (id)objectWithClass:(Class)cls;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;


- (id)objectWithClass:(Class)cls;

- (id)objectWithClass:(Class)cls
                owner:(id)owner;

- (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;

@end
