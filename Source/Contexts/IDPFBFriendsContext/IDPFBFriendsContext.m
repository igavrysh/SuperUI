//
//  IDPFBFriendsContext.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsContext.h"

#import "IDPArrayModel.h"
#import "IDPUser.h"

@interface IDPFBFriendsContext ()
@property (nonatomic, strong) IDPUser           *user;
@property (nonatomic, strong) IDPArrayModel     *friends;

@end

@implementation IDPFBFriendsContext

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithUser:(IDPUser *)user
                        friends:(IDPUserArrayModel *)friends
{
    return [[self alloc] initWithUser:user
                              friends:friends];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user
                     friends:friends
{
    self = [super init];

    self.user = user;
    self.friends = friends;
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    //return [NSString stringWithFormat:@"/%@/%@", self.user.Id, kIDPFriends];
    return [NSString stringWithFormat:@"me/%@", kIDPFriends];
}

- (NSDictionary *)requestParameters {
    return @{kIDPFields:[NSString stringWithFormat:@"%@, %@, %@, %@",
                         kIDPId,
                         kIDPFirstName,
                         kIDPLastName,
                         kIDPLargePicture]};
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    NSArray *friendArray = [result objectForKey:@"data"];
    
    NSLog(@"resut = %@", result);
}

@end
