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
#import "IDPFBConstants.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "NSDictionary+IDPJSONAdapter.h"
#import "IDPJSONAdapter.h"

@interface IDPFBFriendsContext ()
@property (nonatomic, strong)   IDPFBUser   *user;

- (NSSet *)friendsWithInfo:(NSDictionary *)info;
- (IDPFBUser *)userWithInfo:(NSDictionary *)info;

@end

@implementation IDPFBFriendsContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFBUser:(IDPFBUser *)user
                       friends:(IDPFBFriendsArrayModel *)friends
{
    self = [super initWithModel:friends];
    
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPFBUser *user = (IDPFBUser *)self.model;
    
    return [NSString stringWithFormat:@"%@/%@", user.managedObjectID, kIDPFriends];
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
    IDPFBFriendsArrayModel *friends = self.model;
    
    NSSet *friendsArray = [self friendsWithInfo:[result JSONRepresentation]];
    
    friends
    
    friends.state = IDPModelDidLoad;
}

- (NSSet *)friendsWithInfo:(NSDictionary *)info {
    NSMutableSet *friends = [NSMutableSet new];
    NSArray *dataArray = [info objectForKey:kIDPData];
    
    [dataArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        [friends addObject:[self userWithInfo:friendInfo]];
    }];
    
    return friends;
}

- (IDPFBUser *)userWithInfo:(NSDictionary *)info {
    IDPFBUser *user = [IDPFBUser managedObjectWithID:info[kIDPID]];
    user.firstName = info[kIDPFirstName];
    user.lastName = info[kIDPLastName];
    //user.imageURL = [NSURL URLWithString:info[kIDPPicture][kIDPData][kIDPURL]];
    user.state = IDPModelDidLoad;
    
    [user saveManagedObject];
    
    return user;
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    /*
    
    IDPUser *user = (IDPUser *)self.model;
    
    [user performBlockWithoutNotification:^{
        [user load];
    }];
    
    IDPArrayModel *friends = user.friends;
    
    [friends.objects performBlockWithEachObject:^(IDPUser *user) {
        [user load];
    }];
    
    friends.state = IDPModelDidLoad;
     
     */
}

@end
