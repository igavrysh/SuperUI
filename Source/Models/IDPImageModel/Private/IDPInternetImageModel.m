//
//  IDPGlobalImageModel.m
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPInternetImageModel.h"

#import "IDPGCDQueue.h"

#import "NSFileManager+IDPExtensions.h"

#import "IDPErrorMacros.h"

static NSString * const IDPImageCahceFolder = @"images";

@interface IDPInternetImageModel ()
@property (nonatomic, strong)   NSURLSessionDownloadTask    *task;

- (void)performLoadingWithInternetURL:(NSURL *)url;

- (void)saveData:(NSData *)data;

- (void)removeCache;

@end

@implementation IDPInternetImageModel

@dynamic localURL;
@dynamic cached;

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
    
    NSCharacterSet *charset = [NSCharacterSet alphanumericCharacterSet];
    NSString *host = [url.host stringByAddingPercentEncodingWithAllowedCharacters:charset];
    NSString *relativePath = [url.relativePath stringByAddingPercentEncodingWithAllowedCharacters:charset];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@%@",
                      [NSFileManager cachesPath],
                      IDPImageCahceFolder,
                      host,
                      relativePath];
    
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
        [self performBlockWithoutNotification:^{
            [super performLoadingWithURL:self.localURL completionBlock:^(NSData *data, NSError **error) {
                if (!data || *error) {
                    NSLog(@"Error: reading from the local cache");
                    
                    [self removeCache];
                
                    [self performLoading];
                } else {
                    [self performBlockWithNotification:^{
                        [self notifyOfStateChange:self.state];
                    }];
                }
            }];
        }];
        
        return;
    }
    
    [self performLoadingWithInternetURL:self.url];
}

- (void)cancelLoad {
    [self.task cancel];
}

#pragma mark -
#pragma mark Private Methods

- (void)performLoadingWithInternetURL:(NSURL *)url {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    id completionHandler = ^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = location.dataRepresentation;
        
        self.image = [UIImage imageWithData:data];
        
        self.state = !self.image || error ? IDPModelDidFailLoading : IDPModelDidLoad;
        
        if (data && !error) {
            [self saveData:data];
        }
    };
    
    self.task = [session downloadTaskWithURL:url
                           completionHandler:completionHandler];
    
    [self.task resume];
}

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
    [[NSFileManager defaultManager] removeFileAtURL:self.localURL];
    self.image = nil;
}

@end
