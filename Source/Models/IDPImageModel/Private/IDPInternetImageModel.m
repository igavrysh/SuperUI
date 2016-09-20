//
//  IDPGlobalImageModel.m
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPInternetImageModel.h"

#import "IDPGCDQueue.h"

#import "IDPBlockTypes.h"

#import "NSFileManager+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

#import "IDPErrorMacros.h"
#import "IDPDispatchMacros.h"

@interface IDPInternetImageModel ()
@property (nonatomic, strong)       NSURLSessionDownloadTask    *task;
@property (nonatomic, readonly)     NSString                    *fileName;
@property (nonatomic, strong)       NSString                    *imagesCachePath;

- (void)saveData:(NSData *)data;

- (void)removeCache;

@end

@implementation IDPInternetImageModel

@dynamic localURL;
@dynamic cached;
@dynamic fileName;
@dynamic imagesCachePath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancelLoad];
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    NSURL *url = self.url;
    
    if (url.isFileURL) {
        return url;
    }
    
    NSString *path = [self.imagesCachePath stringByAppendingPathComponent:self.fileName];
    
    return [NSURL fileURLWithPath:path isDirectory:NO];
}

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtURL:self.localURL];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block
{
    if (self.isCached) {
        [super performLoadingWithURL:self.localURL completionBlock:^(UIImage *image, NSError *error) {
            if (!image || error) {
                [self removeCache];
                
                [self performLoadingWithURL:self.url completionBlock:block];
            } else {
                IDPPerformBlock(block, image, error);
            }
        }];
    } else {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        id completionHandler = ^(NSURL *location, NSURLResponse *response, NSError *error) {
            [super performLoadingWithURL:location completionBlock:^(UIImage *image, NSError *error) {
                IDPPerformBlock(block, image, error);
            }];
            
            if (!error) {
                [self saveData:location.dataRepresentation];
            }
        };
        
        self.task = [session downloadTaskWithURL:url
                               completionHandler:completionHandler];
        
        [self.task resume];
    }
}

- (void)cancelLoad {
    [self.task cancel];
}

#pragma mark -
#pragma mark Private Methods

- (void)saveData:(NSData *)data {
    IDPAsyncPerformInBackgroundQueue(^{
        NSURL *localURL = self.localURL;
        NSURL *directoryURL = [localURL URLByDeletingLastPathComponent];
        
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL error:&error];
        
        [data writeToURL:localURL options:NSAtomicWrite error:&error];
        
        IDPReturnVoidIfError(error);
    });
}

- (void)removeCache {
    NSError *error = nil;
    
    [[NSFileManager defaultManager] removeFileAtURL:self.localURL error:&error];
}

- (NSString *)fileName {
    NSString *fileName = self.url.relativePath;
    NSString *extension = [fileName pathExtension];
    fileName = [fileName stringByDeletingPathExtension];
    fileName = [fileName stringByAddingPercentEncodingWithAlphanumericCharSet];
    
    return [fileName stringByAppendingPathExtension:extension];
}

- (NSString *)imagesCachePath {
    NSString *cachePath = [NSFileManager imagesCachePath];
    
    NSString *host = [self.url.host stringByAddingPercentEncodingWithAlphanumericCharSet];
        
    return [cachePath stringByAppendingPathComponent:host];
}

@end
