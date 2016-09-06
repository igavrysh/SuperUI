//
//  UINib+IDPExtensions.h
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (IDPExtensions)

+ (UINib *)nibWithClass:(Class)cls;
+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner;

+ (id)objectWithClass:(Class)cls
                owner:(id)owner
              options:(NSDictionary *)options;


- (id)objectWithClass:(Class)cls;

- (id)objectWithClass:(Class)cls owner:(id)owner;

- (NSArray *)objectsWithOwner:(id)owner options:(NSDictionary *)options;

@end
