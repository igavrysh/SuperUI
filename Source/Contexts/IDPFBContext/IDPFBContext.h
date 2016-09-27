//
//  IDPFBContext.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPContext.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPMe, @"me");

kIDPStringVariableDefinition(kIDPPublicProfile, @"public_profile");
kIDPStringVariableDefinition(kIDPUserFrineds, @"user_friends");
kIDPStringVariableDefinition(kIDPFields, @"fields");
kIDPStringVariableDefinition(kIDPId, @"id");
kIDPStringVariableDefinition(kIDPFirstName, @"first_name");
kIDPStringVariableDefinition(kIDPLastName, @"last_name");
kIDPStringVariableDefinition(kIDPLargePicture, @"picture.type(large)");
kIDPStringVariableDefinition(kIDPFriends, @"friends");

@interface IDPFBContext : IDPContext
@property (nonatomic, readonly) NSString        *graphPath;    
@property (nonatomic, readonly) NSDictionary    *requestParameters;

- (void)fillWithResult:(id)result;

@end
