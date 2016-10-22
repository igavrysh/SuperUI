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

@interface IDPFBFriendsContext ()
@property (nonatomic, strong)   IDPFBUser   *user;

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
    NSArray *friendsArray = [result objectForKey:kIDPData];
    
    IDPFBUser *user = self.user;
    
    IDPFBFriendsArrayModel *friends = self.model;
    
    [friendsArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        IDPFBUser *user = [IDPFBUser managedObjectWithID:kIDPID];
        user.firstName = friendInfo[kIDPFirstName];
        user.lastName = friendInfo[kIDPLastName];
        //user.imageURL = [NSURL URLWithString:friendInfo[kIDPPicture][kIDPData][kIDPURL]];
        user.state = IDPModelDidLoad;
        
        [friends performBlockWithoutNotification:^{
            [friends addObject:user];
        }];
    }];
    
    [user saveManagedObject];
    
    friends.state = IDPModelDidLoad;
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
