//
//  IDPFBFriendsContext.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsContext.h"

#import "IDPArrayModel.h"
#import "IDPFBFriendsArrayModel.h"
#import "IDPFBUser.h"
#import "IDPFBImage.h"
#import "IDPFBConstants.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSDictionary+IDPJSONAdapter.h"
#import "IDPJSONAdapter.h"

@interface IDPFBFriendsContext ()
@property (nonatomic, strong, readonly) IDPFBUser   *user;

- (NSArray *)friendsWithInfo:(NSDictionary *)info;

- (IDPFBUser *)userWithInfo:(NSDictionary *)info;

@end

@implementation IDPFBFriendsContext

@dynamic user;

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return [NSString stringWithFormat:@"%@/%@",
            self.user.managedObjectID,
            kIDPGraphKeyFriends];
}

- (NSDictionary *)requestParameters {
    return @{kIDPFields:[NSString stringWithFormat:@"%@, %@, %@, %@",
                         kIDPID,
                         kIDPGraphKeyFirstName,
                         kIDPGraphKeyLastName,
                         kIDPGraphKeyLargePicture]};
}

- (IDPFBUser *)user {
    return self.model;
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    IDPFBFriendsArrayModel *friends = self.user.friendsArray;
    
    NSArray *friendsArray = [self friendsWithInfo:[result JSONRepresentation]];
    
    [friends addObjects:friendsArray];
    
    [self.user saveManagedObject];
    
    [friends performLoading];
    
    self.user.state = IDPFBUserDidLoadFriends;
}

- (NSArray *)friendsWithInfo:(NSDictionary *)info {
    NSMutableArray *friends = [NSMutableArray new];
    NSArray *dataArray = [info objectForKey:kIDPData];
    
    [dataArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        [friends addObject:[self userWithInfo:friendInfo]];
    }];
    
    return friends;
}

- (IDPFBUser *)userWithInfo:(NSDictionary *)info {
    IDPFBUser *user = [IDPFBUser managedObjectWithID:info[kIDPID]];
    user.firstName = info[kIDPGraphKeyFirstName];
    user.lastName = info[kIDPGraphKeyLastName];
    user.profileImage = [IDPFBImage managedObjectWithID:info[kIDPPicture][kIDPData][kIDPURL]];
    user.state = IDPFBUserDidLoadId;
    
    return user;
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    IDPFBUser *user = self.user;
    
    IDPFBFriendsArrayModel *friends = user.friendsArray;
    
    [friends performLoading];
    
    self.user.state = IDPFBUserDidLoadFriends;
}

@end
