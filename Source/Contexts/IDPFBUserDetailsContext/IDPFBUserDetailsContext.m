//
//  IDPFBFriendDetailsContext.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUserDetailsContext.h"

#import "IDPUser.h"
#import "IDPFBConstants.h"

@implementation IDPFBUserDetailsContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithModel:(IDPUser *)user {
    self = [super initWithModel:user];
    user.state = IDPModelDidUnload;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    IDPUser *user = (IDPUser *)self.model;
    
    return [NSString stringWithFormat:@"%@", user.ID];
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
    IDPUser *user = (IDPUser *)self.model;
    user.name = result[kIDPName];
    user.bigImageURL = [NSURL URLWithString:result[kIDPPicture][kIDPData][kIDPURL]];

    user.state = IDPModelDidLoad;
    
    [user save];
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    IDPUser *user = (IDPUser *)self.model;
    
    [user load];
}

@end
