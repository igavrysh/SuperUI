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

#import "IDPErrorMacros.h"

@interface IDPLocalImageModel ()
@property (nonatomic, strong)   NSURL       *url;

- (void)dump;

- (void)removeCache;

@end

@implementation IDPLocalImageModel

@dynamic localURL;
@dynamic cached;

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
#pragma mark Accessors

- (NSURL *)localURL {
    NSURL *url = self.url;
    
    if ([url isFileURL]) {
        return url;
    }
    
    NSString *cachePath = [NSFileManager cachesPath];
    NSString *host = [url.host stringByReplacingOccurrencesOfString:@"."
                                                         withString:@"/"];
    NSString *relativePath = url.relativePath;
    
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/images/%@%@",
                                   cachePath,
                                   host,
                                   relativePath]];
}

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtURL:self.localURL];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    NSError *error = nil;
    NSURL *url = self.url;
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    if (error) {
        [self removeCache];
        
        return;
    }
    
    self.image = [UIImage imageWithData:data];
    
    if (!self.image) {
        [self removeCache];
        
        return;
    }
    
    self.state = IDPModelDidLoad;
}

#pragma mark -
#pragma mark Private Methods

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

- (void)removeCache {
    [[NSFileManager defaultManager] removeFileAtURL:self.url];
    self.image = nil;
}

@end
