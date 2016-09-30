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

@end

@implementation IDPFBFriendsContext

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithUser:(IDPUser *)user {
    return [[self alloc] initWithUser:user];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user {
    self = [super initWithModel:user];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPUser *user = (IDPUser *)self.model;
    
    return [NSString stringWithFormat:@"%@/%@", user.ID, kIDPFriends];
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
    
    IDPArrayModel *friends = ((IDPUser *)self.model).friends;
    
    [friendsArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        IDPUser *user = [IDPUser new];
        user.ID = friendInfo[kIDPID];
        user.firstName = friendInfo[kIDPFirstName];
        user.lastName = friendInfo[kIDPLastName];
        user.imageURL = [NSURL URLWithString:friendInfo[kIDPPicture][kIDPData][kIDPURL]];
        user.state = IDPUserDidLoadBasicInformation;
        
        [friends performBlockWithoutNotification:^{
            [friends addObject:user];
        }];
    }];
    
    friends.state = IDPModelDidLoad;
}

@end
