//
//  IDPGlobalImageModel.m
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPGlobalImageModel.h"

#import "NSFileManager+IDPExtensions.h"

#import "IDPErrorMacros.h"

@interface IDPGlobalImageModel ()
@property (nonatomic, readonly, getter=isCacheExists)   BOOL    cacheExists;

- (void)save;
@end

@implementation IDPGlobalImageModel

@dynamic localURL;
@dynamic cacheExists;

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    NSString *cachePath = [NSFileManager cachesPath];
    NSString *host = [self.url.host stringByReplacingOccurrencesOfString:@"."
                                                              withString:@"/"];
    NSString *relativePath = self.url.relativePath;
    
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/images/%@%@",
                                   cachePath,
                                   host,
                                   relativePath]];
}

- (BOOL)isCacheExists {
    return [[NSFileManager defaultManager] fileExistsAtURL:self.localURL];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    if (!self.isCacheExists) {
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:self.url
                                             options:NSDataReadingMappedIfSafe
                                               error:&error];
        if (error) {
            self.state = IDPModelDidFailLoading;
            
            return;
        }
    
        self.image = [UIImage imageWithData:data];
    
        [self save];
    }
    
    [super performLoading];
}

#pragma mark -
#pragma mark Private Methods

- (void)save {
    NSURL *localURL = self.localURL;
    
    NSData *data = nil;
    NSString * extension = [localURL.pathExtension lowercaseString];
    if ([extension isEqualToString:@"png"]) {
        data = UIImagePNGRepresentation(self.image);
    } else if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"jpeg"]) {
        data = UIImageJPEGRepresentation(self.image, 1.0);
    } else {
        self.state = IDPModelDidFailLoading;
        
        return;
    }
    
    NSError *error = nil;
    [[NSFileManager defaultManager] saveData:data atURL:localURL error:&error];
 
    IDPReturnVoidIfError(error);
}

@end
