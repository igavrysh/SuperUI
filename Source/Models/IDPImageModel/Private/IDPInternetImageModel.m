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

@interface IDPInternetImageModel ()

- (void)saveData:(NSData *)data;

- (void)removeCache;

@end

@implementation IDPInternetImageModel

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    [self performBlockWithoutNotification:^{
        if (self.cached) {
            [super performLoading];
        }
    }];
    
    if (IDPModelDidFailLoading == self.state) {
        [self removeCache];
    } else {
        [self notifyOfStateChange:self.state];
        
        return;
    }
    
    IDPImageLoadingCompletionBlock completionBlock = ^(UIImage *image, NSError **error){
        if (!self.image || error) {
            self.state = IDPModelDidFailLoading;
        } else {
            self.state = IDPModelDidLoad;
            
            [self saveData:UIImagePNGRepresentation(image)];
        }
    };
    
    [self performLoadingWithURL:self.url
                completionBlock:completionBlock];
}

#pragma mark -
#pragma mark Private Methods

- (void)saveData:(NSData *)data {
    IDPWeakify(self);
    IDPAsyncPerformInBackgroundQueue(^{
        IDPStrongify(self);
        
        NSURL *localURL = self.localURL;
        NSURL *directoryURL = [localURL URLByDeletingLastPathComponent];
        
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL error:&error];
        
        [data writeToURL:localURL options:NSAtomicWrite error:&error];
        
        IDPReturnVoidIfError(error);
    });
}

- (void)removeCache {
    [[NSFileManager defaultManager] removeFileAtURL:self.url];
    self.image = nil;
}

@end
