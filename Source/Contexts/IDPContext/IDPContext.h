//
//  IDPContext.h
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPModel;

@interface IDPContext : NSObject
@property (nonatomic, readonly)     IDPModel    *model;

- (void)execute;
- (void)cancel;

// Method for override
- (void)load;

@end
