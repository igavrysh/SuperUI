//
//  IDPImageModel.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPGCDQueue.h"
#import "IDPObjectsCache.h"

#import "NSFileManager+IDPExtensions.h"

#import "IDPMacros.h"

@interface IDPImageModel ()
@property (nonatomic, strong)   NSURL               *url;

- (void)dump;

@end

@implementation IDPImageModel

@dynamic localURL;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    id object = [[IDPObjectsCache cache] objectForKey:url];
    if (object) {
        self = nil;
        
        return object;
    }
    
    self = [super init];
    
    self.url = url;
    
    [[IDPObjectsCache cache] setObject:self forKey:url];

    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    return self.url;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    NSURL *url = self.localURL;
    
    NSData * data = [NSData dataWithContentsOfFile:url.path];
    
    self.image = [UIImage imageWithData:data];
    
    if (!self.image) {
        [[NSFileManager defaultManager] removeFileAtURL:url];
        
        [super load];
    } else {
        self.state = IDPModelDidLoad;
    }
}

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

@end
