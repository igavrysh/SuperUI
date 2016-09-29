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
#import "IDPFBConstants.h"
#import "NSArray+IDPArrayEnumerator.h"

@interface IDPFBFriendsContext ()
@property (nonatomic, strong) IDPUser           *user;

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
    self = [super initWithModel:friends];

    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return [NSString stringWithFormat:@"%@/%@", self.user.ID, kIDPFriends];
}

- (NSDictionary *)requestParameters {
    return @{kIDPFields:[NSString stringWithFormat:@"%@, %@, %@, %@",
                         kIDPID,
                         kIDPFirstName,
                         kIDPLastName,
                         kIDPLargePicture]};
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    NSArray *friendsArray = [result objectForKey:kIDPData];
    
    IDPArrayModel *friends = (IDPArrayModel *)self.model;
    
    [friendsArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        IDPUser *user = [IDPUser new];
        user.ID = friendInfo[kIDPID];
        user.firstName = friendInfo[kIDPFirstName];
        user.lastName = friendInfo[kIDPLastName];
        user.imageURL = [NSURL URLWithString:friendInfo[kIDPPicture][kIDPData][kIDPURL]];
        
        [friends performBlockWithoutNotification:^{
            [friends addObject:user];
        }];
    }];
    
    friends.state = IDPModelDidLoad;
}

@end
