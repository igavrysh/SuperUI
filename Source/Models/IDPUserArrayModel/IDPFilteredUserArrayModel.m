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
#pragma mar Initializations and Deallocations

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel
                            filter:(NSString *)filter
{
    self = [super init];
    self.arrayModel = arrayModel;
    self.filter = filter;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setFilter:(NSString *)filter{
    if (_filter!= filter) {
        _filter = filter;
        
        self.state = IDPLoadableModelLoading;
        
        [self filterArrayModel];
    }
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObjects:nil filter:@""];
}

- (instancetype)initWithObjects:(NSArray *)objects {
    return [self initWithObjects:objects filter:@""];
}

- (instancetype)initWithFilter:(NSString *)filter {
    return [self initWithObjects:nil filter:filter];
}

- (instancetype)initWithObjects:(NSArray *)objects
                         filter:(NSString *)filter
{
    self = [super initWithObjects:objects];
    
    self.filter = filter;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)isObjectEligible:(IDPUser *)user {
    return NSNotFound != [user.name rangeOfString:self.filter
                                          options:NSCaseInsensitiveSearch].location;
}

@end
