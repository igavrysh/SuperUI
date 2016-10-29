//
//  IDPFBFriendDetailsContext.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUserDetailsContext.h"

#import "IDPFBUser.h"
#import "IDPFBImage.h"
#import "IDPFBConstants.h"

@implementation IDPFBUserDetailsContext

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPFBUser *user = (IDPFBUser *)self.model;
    
    return [NSString stringWithFormat:@"%@", user.managedObjectID];
}

- (NSDictionary *)requestParameters {
    return @{kIDPFields:[NSString stringWithFormat:@"%@, %@, %@, %@, %@",
                         kIDPLargePicture,
                         kIDPName,
                         kIDPLocation,
                         kIDPHometown,
                         kIDPWork]};
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    IDPFBUser *user = (IDPFBUser *)self.model;
    user.name = result[kIDPName];
    user.bigProfileImage = [IDPFBImage managedObjectWithID:result[kIDPPicture][kIDPData][kIDPURL]];
    
    [NSURL URLWithString:result[kIDPPicture][kIDPData][kIDPURL]];

    user.state = IDPFBUserDidLoadDetails;
    
    [user saveManagedObject];
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    NSString *managedObjectID = ((IDPFBUser *)self.model).managedObjectID;
    
    IDPFBUser *user = [IDPFBUser managedObjectWithID:managedObjectID];
    
    user.state = IDPFBUserDidLoadDetails;
}

@end
