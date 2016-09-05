//
//  UINib+IDPExtensions.h
//  iOSProject
//
//  Created by Ievgen on 8/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (IDPExtensions)

+ (UINib *)nibWithClass:(Class)class;
+ (UINib *)nibWithClass:(Class)class bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;
+ (id)objectWithClass:(Class)cls owner:(id)owner;
+ (id)objectWithClass:(Class)cls inBundle:(NSBundle *)bundle;
+ (id)objectWithClass:(Class)cls inBundle:(NSBundle *)bundle owner:(id)owner;

- (id)objectWithClass:(Class)cls owner:(id)owner;
- (NSArray *)objectsWithOwner:(id)owner options:(NSDictionary *)options;

@end
