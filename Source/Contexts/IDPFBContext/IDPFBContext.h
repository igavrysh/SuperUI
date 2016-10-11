//
//  IDPFBContext.h
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPContext.h"

@interface IDPFBContext : IDPContext
@property (nonatomic, readonly) NSString        *graphPath;    
@property (nonatomic, readonly) NSDictionary    *requestParameters;

// Methods for override
- (NSString *)httpMethod;

- (void)fillWithResult:(id)result;

- (void)didFailLoadingFromInternet:(NSError *)error;

@end
