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

#import "IDPMacros.h"

static NSString * const kIDPImageName = @"image_big";
static NSString * const kIDPImageExtension = @"jpg";

kIDPModelObjectsKey(kIDPUserNameKey);
kIDPModelObjectsKey(kIDPUserSurnameKey);
kIDPModelObjectsKey(kIDPUserURLKey);

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

+ (NSMutableArray *)usersWithCount:(NSUInteger)count {
    NSMutableArray *users = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        [users addObject:[IDPUser user]];
    }
    
    return users;
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
    self.imageURL = [coder decodeObjectForKey:kIDPUserURLKey];
    
    return self;
}

@end
