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

- (void)fillWithResult:(id)result;

// Method for override
- (NSString *)httpMethod;

@end
