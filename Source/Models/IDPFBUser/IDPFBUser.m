//
//  IDPUser.m
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUser.h"

#import "IDPImageModel.h"
#import "IDPArrayModel.h"

#import "IDPJSONAdapter.h"
#import "NSString+IDPRandomName.h"
#import "NSArray+IDPArrayEnumerator.h"
#import "NSBundle+IDPExtensions.h"
#import "NSFileManager+IDPExtensions.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPSampleImageURL,
                             @"https://pbs.twimg.com/profile_images/609903623640723457/A4B7DT8s.png");

kIDPStringVariableDefinition(kIDPRootKey, @"archive");
kIDPStringKeyDefinition(kIDPUserID);
kIDPStringKeyDefinition(kIDPUserFirstNameKey);
kIDPStringKeyDefinition(kIDPUserLastNameKey);
kIDPStringKeyDefinition(kIDPUserNameKey);
kIDPStringKeyDefinition(kIDPUserLocationKey);
kIDPStringKeyDefinition(kIDPUserHometownKey);
kIDPStringKeyDefinition(kIDPUserImageURLKey);
kIDPStringKeyDefinition(kIDPUserBigImageURLKey);
kIDPStringKeyDefinition(kIDPUserFriendIDsKey);

@interface IDPFBUser ()
@property (nonatomic, strong)   IDPArrayModel   *friends;
@property (nonatomic, strong)   NSArray         *friendIDs;

@end

@implementation IDPFBUser

@dynamic fullName;
@dynamic imageModel;
@dynamic friendIDs;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)userWithID:(NSString *)ID {
    return [[self alloc] initWithID:ID];
}

+ (instancetype)user {
    return [IDPFBUser new];
}

+ (NSArray *)usersWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count block:^{ return [IDPFBUser user]; }];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithID:(NSString *)ID {
    self = [self init];
    self.ID = ID;
    
    return self;
}

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

- (IDPImageModel *)bigImageModel {
    IDPImageModel *model = [IDPImageModel imageWithURL:self.bigImageURL];
    
    return model;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)friendIDs {
    NSMutableArray *friendIDs = [NSMutableArray new];
    
    [self.friends.objects performBlockWithEachObject:^(IDPFBUser *user) {
        [friendIDs addObject:user.ID];
    }];
    
    return [friendIDs copy];
}

- (void)setFriendIDs:(NSArray *)frinedIDs {
    [frinedIDs performBlockWithEachObject:^(NSString *ID) {
        IDPFBUser *user = [IDPFBUser userWithID:ID];
        user.state = IDPModelDidUnload;
        
        [self.friends addObject:user];
    }];
}

- (NSString *)plistName {
    return [NSString stringWithFormat:@"%@.plist", self.ID];
}

- (BOOL)isCacheExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.cachePath];
}

- (NSString *)cachePath {
    return [[NSFileManager applicationCachePath] stringByAppendingPathComponent:self.plistName];
}

#pragma mark -
#pragma mark Public Methods

- (void)save {
    [NSKeyedArchiver archiveRootObject:[self JSONRepresentation]
                                toFile:self.cachePath];
    
    [self.friends.objects performBlockWithEachObject:^(IDPFBUser *user) {
        [user save];
    }];

}

- (void)load {
    NSDictionary *archiver = [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachePath][kIDPRootKey];
    
    if (!archiver) {
        self.state = IDPModelDidFailLoading;
        
        return;
    }
    
#define IDPDecode(key, property) self.property = archiver[key];
    
    IDPDecode(kIDPUserID, ID)
    IDPDecode(kIDPUserFirstNameKey, firstName)
    IDPDecode(kIDPUserLastNameKey, lastName)
    IDPDecode(kIDPUserNameKey, name)
    IDPDecode(kIDPUserLocationKey, location)
    IDPDecode(kIDPUserHometownKey, hometown)
    IDPDecode(kIDPUserImageURLKey, imageURL)
    IDPDecode(kIDPUserBigImageURLKey, bigImageURL)
    IDPDecode(kIDPUserFriendIDsKey, friendIDs)
    
#undef IDPDecode
    
    self.state = IDPFBUserDidLoad;
}

#pragma mark -
#pragma mark Private Methods

- (NSDictionary *)JSONRepresentation {
    NSMutableDictionary *archive = [NSMutableDictionary new];
    
#define IDPEncode(key, value) archive[key] = self.value;
    
    IDPEncode(kIDPUserID, ID)
    IDPEncode(kIDPUserFirstNameKey, firstName)
    IDPEncode(kIDPUserLastNameKey, lastName)
    IDPEncode(kIDPUserNameKey, name)
    IDPEncode(kIDPUserLocationKey, location)
    IDPEncode(kIDPUserHometownKey, hometown)
    IDPEncode(kIDPUserImageURLKey, imageURL)
    IDPEncode(kIDPUserBigImageURLKey, bigImageURL)
    IDPEncode(kIDPUserFriendIDsKey, friendIDs)
    
#undef IDPEncode
    
    return [NSDictionary dictionaryWithObject:archive forKey:kIDPRootKey];
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPFBUserDidUnload:
            return @selector(userDidUnload:);
        
        case IDPFBUserWillLoad:
            return @selector(userWillLoad:);
            
        case IDPFBUserDidLoad:
            return @selector(userDidLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
