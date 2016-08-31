//
//  NSBundle+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (IDPExtensions)

+ (id)objectFromMainBundleWithClass:(Class)class;

+ (id)objectFromBundle:(NSBundle *)bundle
             withClass:(Class)class;

@end
