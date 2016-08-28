//
//  IDPUser.m
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUser.h"

#import "IDPImageModel.h"

#import "NSString+IDPRandomName.h"

NSString * const kIDPImageName = @"image_big";
NSString * const kIDPImageExtension = @"jpg";

@implementation IDPUser

@dynamic fullName;
@dynamic imageModel;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)user {
    IDPUser *user = [IDPUser new];
    
    user.name = [NSString randomName];
    user.surname = [NSString randomName];
    user.imageURL = [[NSBundle mainBundle] URLForResource:kIDPImageName
                                            withExtension:kIDPImageExtension];
    
    return user;
}

#pragma mark - 
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (IDPImageModel *)imageModel {
    return [IDPImageModel imageWithURL:self.imageURL];
}

#pragma mark -
#pragma mark NSCopying 

- (id)copyWithZone:(NSZone *)zone {
    IDPUser *user = [IDPUser new];
    
    user.name = self.name;
    user.surname = self.surname;
    user.imageURL = self.imageURL;
    
    return user;
}

@end
