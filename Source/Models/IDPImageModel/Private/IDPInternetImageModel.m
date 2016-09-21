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

- (void)removeCache:(NSError **)error;

@end

@implementation IDPInternetImageModel

@dynamic localURL;
@dynamic cached;
@dynamic fileName;
@dynamic imagesCachePath;
@dynamic session;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self.task cancel];
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

- (void)setTask:(NSURLSessionDownloadTask *)task {
    if (_task != task) {
        [_task cancel];
        
        _task = task;
        
        [task resume];
    }
}

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtURL:self.localURL];
}

- (NSURLSession *)session {
    IDPFactoryBlock block = ^{
        NSURLSessionConfiguration *settings = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        return [NSURLSession sessionWithConfiguration:settings];
    };
    
    IDPReturnAfterSettingVariableWithBlockOnce(block);
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block
{
    id sessionBlock = ^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager copyItemWithDirectoryCreationAtURL:location
                                                  toURL:self.localURL
                                                  error:&error];
            
            [super performLoadingWithURL:location completionBlock:block];
        }
    };
    
    id completionBlock = ^(UIImage *image, NSError *error) {
        if (!image || error) {
            error = nil;
            
            [self removeCache:&error];
            
            self.task = [self.session downloadTaskWithURL:self.url
                                        completionHandler:sessionBlock];
        }
        
        IDPPerformBlock(block, image, error);
    };
    
    [super performLoadingWithURL:self.localURL completionBlock:completionBlock];
}

#pragma mark -
#pragma mark Private Methods

- (void)removeCache:(NSError **)error {
    [[NSFileManager defaultManager] removeFileAtURL:self.localURL error:error];
}

- (NSString *)fileName {    
    return [self.url.relativePath stringByAddingPercentEncodingWithAlphanumericCharSet];
}

- (NSString *)imagesCachePath {
    NSString *cachePath = [NSFileManager imagesCachePath];
    
    NSString *host = [self.url.host stringByAddingPercentEncodingWithAlphanumericCharSet];
        
    return [cachePath stringByAppendingPathComponent:host];
}

@end
