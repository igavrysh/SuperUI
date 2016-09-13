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

@end

@implementation IDPInternetImageModel

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    if (self.cached) {
        [super performLoading];
        
        if (self.image) {
            return;
        }
    }
    
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:self.url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    if (error) {
        self.state = IDPModelDidFailLoading;
        
        return;
    }
    
    self.image = [UIImage imageWithData:data];
    
    if (!self.image) {
        self.state = IDPModelDidFailLoading;
        
        return;
    }
    
    self.state = IDPModelDidLoad;
    
    [self saveData:data];
}

#pragma mark -
#pragma mark Private Methods

- (void)saveData:(NSData *)data {
    IDPWeakify(self);
    IDPAsyncPerformInBackgroundQueue(^{
        IDPStrongify(self);
        
        NSURL *localURL = self.localURL;
        
        NSError *error = nil;
        [data writeToURL:localURL options:NSAtomicWrite error:&error];
        
        IDPReturnVoidIfError(error);
    });
}

@end
