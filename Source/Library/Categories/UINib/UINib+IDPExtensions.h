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

+ (id)objectFromNibWithClass:(Class)class;
+ (id)objectFromNibWithClass:(Class)class inBundle:(NSBundle *)bundle;

- (id)objectWithClass:(Class)class;
- (NSArray *)objects;

@end
