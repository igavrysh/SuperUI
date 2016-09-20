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

@end

@implementation IDPLocalImageModel

#pragma mark -
#pragma mark Public Methods

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block
{
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:url
                                         options:NSDataReadingMappedIfSafe
                                           error:&error];
    
    UIImage *image = [UIImage imageWithData:data];
    
    IDPPerformBlock(block, image, error);
}

@end
