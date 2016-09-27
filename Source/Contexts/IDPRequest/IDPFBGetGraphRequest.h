//
//  IDPFBGetGraphRequest.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface IDPFBGetGraphRequest : FBSDKGraphRequest

+ (instancetype)requestWithGraphPath:(NSString *)graphPath
                          parameters:(NSDictionary *)requestParameters;


- (instancetype)initWithGraphPath:(NSString *)graphPath
                       parameters:(NSDictionary *)requestParameters;

@end
