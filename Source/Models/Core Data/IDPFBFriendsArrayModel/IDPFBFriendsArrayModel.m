//
//  IDPFBFriendsArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 10/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsArrayModel.h"

@implementation IDPFBFriendsArrayModel

#pragma mark -
#pragma mark Public Methods

- (NSArray *)sortDescriptors {
    return @[[[NSSortDescriptor alloc] initWithKey:@"<#Sort key#>" ascending:YES]];
}

@end
