//
//  IDPObjectsCache.h
//  SuperUI
//
//  Created by Ievgen on 9/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPObjectsCache : NSObject

+ (instancetype)cache;

- (id)objectForKey:(id)key;

- (void)setObject:(id)object forKey:(id)key;

@end
