//
//  IDPLocalImageModel.m
//  SuperUI
//
//  Created by Ievgen on 9/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLocalImageModel.h"

#import "IDPObjectsCache.h"

#import "NSFileManager+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

#import "IDPErrorMacros.h"

@interface IDPLocalImageModel ()

- (void)dump;

@end

@implementation IDPLocalImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark - 
#pragma mark Initializaitons and Deallocations

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
#pragma mark Public Methods

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block
{
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    
    self.image = [UIImage imageWithData:data];
    
    self.state = !self.image || error ? IDPModelDidFailLoading : IDPModelDidLoad;
    
    IDPPerformBlock(block, data, &error);
}

#pragma mark -
#pragma mark Private Methods

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

@end
