//
//  NSCompoundPredicate+IDPExtensions.h
//  SuperUI
//
//  Created by Ievgen on 10/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCompoundPredicate (IDPExtensions)

- (NSCompoundPredicate *)addAndPredicate:(NSPredicate *)predicate;

@end
