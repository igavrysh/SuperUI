//
//  IDPUser.m
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPUser.h"

#import "IDPImageModel.h"
#import "IDPArrayModel.h"

#import "NSString+IDPRandomName.h"
#import "NSArray+IDPArrayEnumerator.h"
#include "NSBundle+IDPExtensions.h"

#import "IDPMacros.h"

static NSString * const kIDPSampleImageURL = @"https://pbs.twimg.com/profile_images/609903623640723457/A4B7DT8s.png";

kIDPStringKeyDefinition(kIDPUserID);
kIDPStringKeyDefinition(kIDPUserFirstNameKey);
kIDPStringKeyDefinition(kIDPUserLastNameKey);
kIDPStringKeyDefinition(kIDPUserNameKey);
kIDPStringKeyDefinition(kIDPUserLocationKey);
kIDPStringKeyDefinition(kIDPUserHometownKey);
kIDPStringKeyDefinition(kIDPUserImageURLKey);
kIDPStringKeyDefinition(kIDPUserBigImageURLKey);

@interface IDPUser ()
@property (nonatomic, strong)   IDPArrayModel   *friends;

@end

@implementation IDPUser

@dynamic fullName;
@dynamic imageModel;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)user {
    IDPUser *user = [IDPUser new];
    
    user.firstName = [NSString randomName];
    user.lastName = [NSString randomName];
    user.name = [NSString randomName];
    user.location = [NSString randomName];
    user.hometown = [NSString randomName];
    user.imageURL = [NSURL URLWithString:kIDPSampleImageURL];
    user.bigImageURL = [NSURL URLWithString:kIDPSampleImageURL];
    
    return user;
}

+ (NSArray *)usersWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count block:^{ return [IDPUser user]; }];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.friends = [IDPArrayModel new];
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (IDPImageModel *)imageModel {
    IDPImageModel *model = [IDPImageModel imageWithURL:self.imageURL];
    
    return model;
}

#pragma mark -
#pragma mark NSCopying 

- (id)copyWithZone:(NSZone *)zone {
    IDPUser *user = [IDPUser new];
    
    user.ID = self.ID;
    user.firstName = self.firstName;
    user.lastName = self.lastName;
    user.name = self.name;
    user.location = self.location;
    user.hometown = self.hometown;
    
    user.imageURL = self.imageURL;
    user.bigImageURL = self.bigImageURL;
    
    return user;
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.ID forKey:kIDPUserID];
    [coder encodeObject:self.firstName forKey:kIDPUserFirstNameKey];
    [coder encodeObject:self.lastName forKey:kIDPUserLastNameKey];
    [coder encodeObject:self.name forKey:kIDPUserNameKey];
    [coder encodeObject:self.location forKey:kIDPUserLocationKey];
    [coder encodeObject:self.hometown forKey:kIDPUserHometownKey];
    [coder encodeObject:self.imageURL forKey:kIDPUserImageURLKey];
    [coder encodeObject:self.bigImageURL forKey:kIDPUserBigImageURLKey];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    
    self.ID = [coder decodeObjectForKey:kIDPUserID];
    self.firstName = [coder decodeObjectForKey:kIDPUserFirstNameKey];
    self.lastName = [coder decodeObjectForKey:kIDPUserLastNameKey];
    self.name = [coder decodeObjectForKey:kIDPUserNameKey];
    self.location = [coder decodeObjectForKey:kIDPUserLocationKey];
    self.hometown = [coder decodeObjectForKey:kIDPUserHometownKey];
    self.imageURL = [coder decodeObjectForKey:kIDPUserImageURLKey];
    self.bigImageURL = [coder decodeObjectForKey:kIDPUserBigImageURLKey];
    
    return self;
}

#pragma mark - 
#pragma mark IDPObservableObject

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPUserDidLoadID:
            return @selector(userDidLoadID:);
        
        case IDPUserDidLoadBasicInformation:
            return @selector(userDidLoadBasicInformation:);
            
        case IDPUserDidLoadDetails:
            return @selector(userDidLoadDetails:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
