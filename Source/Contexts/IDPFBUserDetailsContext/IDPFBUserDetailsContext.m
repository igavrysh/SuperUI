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

#import "IDPGCDQueue.h"

@implementation IDPFBUserDetailsContext

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPFBUser *user = (IDPFBUser *)self.model;
    
    return [NSString stringWithFormat:@"%@", user.managedObjectID];
}

- (NSDictionary *)requestParameters {
    return @{kIDPFields:[NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",
                         kIDPGraphKeyLargePicture,
                         kIDPGraphKeyName,
                         kIDPGraphKeyLocation,
                         kIDPGraphKeyHometown,
                         kIDPGraphKeyWork,
                         kIDPGraphKeyEmail]};
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithResult:(NSDictionary *)result {
    IDPFBUser *user = (IDPFBUser *)self.model;
    
    user.name = result[kIDPGraphKeyName];
    user.bigProfileImage = [IDPFBImage managedObjectWithID:result[kIDPPicture][kIDPData][kIDPURL]];
    user.location = ((NSDictionary *)result[kIDPGraphKeyLocation])[@"name"];
    user.hometown = ((NSDictionary *)result[kIDPGraphKeyHometown])[@"name"];
    user.email = result[kIDPGraphKeyEmail];
    
    [user saveManagedObject];
    
    user.state = IDPFBUserDidLoadDetails;
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    IDPAsyncPerformInMainQueue(^{
        NSString *managedObjectID = ((IDPFBUser *)self.model).managedObjectID;
        
        IDPFBUser *user = [IDPFBUser managedObjectWithID:managedObjectID];
        
        user.state = IDPFBUserDidLoadDetails;
    });
}

@end
