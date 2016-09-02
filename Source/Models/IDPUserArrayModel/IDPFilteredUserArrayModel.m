//
//  IDPFilteredUserArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 9/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFilteredUserArrayModel.h"

#import "IDPUser.h"

@interface IDPFilteredUserArrayModel ()

@end

@implementation IDPFilteredUserArrayModel

#pragma mark -
#pragma mark Accessors

- (void)setFilter:(NSString *)filter{
    if (_filter!= filter) {
        _filter = filter;
        
        self.state = IDPChangeableModelReloading;
        
        [self filter];
    }
}

#pragma mark -
#pragma mark Public Methods

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithBlock:^BOOL(IDPUser *user, NSDictionary *bindings) {
        if (!self.filter) {
            return YES;
        }
        
        return NSNotFound != [user.name rangeOfString:self.filter
                                              options:NSCaseInsensitiveSearch].location;
    }];
}

@end
