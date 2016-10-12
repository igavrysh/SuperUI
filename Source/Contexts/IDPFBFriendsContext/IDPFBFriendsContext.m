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
    
    IDPUser *user = (IDPUser *)self.model;
    
    IDPArrayModel *friends = user.friends;
    
    [friendsArray performBlockWithEachObject: ^(NSDictionary *friendInfo){
        IDPUser *user = [IDPUser new];
        user.ID = friendInfo[kIDPID];
        user.firstName = friendInfo[kIDPFirstName];
        user.lastName = friendInfo[kIDPLastName];
        user.imageURL = [NSURL URLWithString:friendInfo[kIDPPicture][kIDPData][kIDPURL]];
        user.state = IDPModelDidLoad;
        
        [friends performBlockWithoutNotification:^{
            [friends addObject:user];
        }];
    }];
    
    [user save];
    
    friends.state = IDPModelDidLoad;
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    IDPUser *user = (IDPUser *)self.model;
    
    [user performBlockWithoutNotification:^{
        [user load];
    }];
    
    IDPArrayModel *friends = user.friends;
    
    [friends.objects performBlockWithEachObject:^(IDPUser *user) {
        [user load];
    }];
    
    friends.state = IDPModelDidLoad;
}

@end
