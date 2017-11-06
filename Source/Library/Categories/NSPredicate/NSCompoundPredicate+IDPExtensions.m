//
//  NSCompoundPredicate+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 10/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSCompoundPredicate+IDPExtensions.h"

#import "NSMutableArray+IDPExtensions.h"

@implementation NSCompoundPredicate (IDPExtensions)

#pragma mark -
#pragma mark Public Methods

- (NSCompoundPredicate *)addAndPredicate:(NSPredicate *)predicate {
    if (!predicate) {
        return self;
    }
    
    NSMutableArray *subpredicates = [NSMutableArray new];
    [subpredicates addObjectsFromArray:self.subpredicates];
    [subpredicates addObjectWithNilCheck:predicate];

    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

@end
