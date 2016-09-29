//
//  NSDictionary+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (IDPExtensions)

- (void)performBlockWithEachObject:(void (^)(id object, id key))block;

@end
