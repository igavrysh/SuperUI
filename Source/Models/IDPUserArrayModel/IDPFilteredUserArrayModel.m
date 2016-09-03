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
        
        [self performFiltering];
    }
}

#pragma mark -
#pragma mark Public Methods

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithBlock:^BOOL(IDPUser *user, NSDictionary *bindings) {
        if (!self.filter || [self.filter isEqualToString:@""]) {
            return YES;
        }
        
        NSUInteger res = [user.name rangeOfString:self.filter
                               options:NSCaseInsensitiveSearch].location;
        
        return NSNotFound != res;
    }];
}

@end
