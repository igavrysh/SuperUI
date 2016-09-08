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
#import "NSArray+IDPArrayEnumerator.h"
#include "NSBundle+IDPExtensions.h"

#import "IDPMacros.h"

static NSString * const kIDPImageName = @"image_big";
static NSString * const kIDPImageExtension = @"jpg";

kIDPStringKeyDefinition(kIDPUserNameKey);
kIDPStringKeyDefinition(kIDPUserSurnameKey);
kIDPStringKeyDefinition(kIDPUserURLKey);

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

+ (NSArray *)usersWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count block:^{ return [IDPUser user]; }];
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

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kIDPUserNameKey];
    [coder encodeObject:self.surname forKey:kIDPUserSurnameKey];
    [coder encodeObject:self.imageURL forKey:kIDPUserURLKey];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    
    self.name = [coder decodeObjectForKey:kIDPUserNameKey];
    self.surname = [coder decodeObjectForKey:kIDPUserSurnameKey];
                    
    NSString *fileName = [[coder decodeObjectForKey:kIDPUserURLKey] lastPathComponent];
    self.imageURL = [NSURL URLWithString:[NSBundle pathForBundleFile:fileName]];
    
    return self;
}

@end
