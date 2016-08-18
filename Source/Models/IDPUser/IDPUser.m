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

@implementation IDPUser

@dynamic fullName;
@dynamic imageModel;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)user {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image_big" withExtension:@"jpg"];
    
    return [self userWithName:[NSString randomName]
                      surname:[NSString randomName]
                          url:url];
}

+ (instancetype)userWithName:(NSString *)name
                     surname:(NSString *)surname
                         url:(NSURL *)imageURL
{
    return [[self alloc] initWithName:name
                              surname:surname
                                  url:imageURL];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithName:[NSString randomName]
                      surname:[NSString randomName]
                          url:nil];
}

- (instancetype)initWithName:(NSString *)name
                     surname:(NSString *)surname
                         url:(NSURL *)imageUrl
{
    self = [super init];
    
    self.name = name;
    self.surname = surname;
    self.imageURL = imageUrl;
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (IDPImageModel *)imageModel {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image"
                                         withExtension:@"jpg"];
    
    return [IDPImageModel imageWithURL:url];
}


@end
