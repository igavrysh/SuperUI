//
//  IDPGlobalImageModel.m
//  SuperUI
//
//  Created by Ievgen on 9/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPGlobalImageModel.h"

#import "NSFileManager+IDPExtensions.h"

@implementation IDPGlobalImageModel

@dynamic localURL;

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    NSString *cachePath = [NSFileManager cachesPath];
    NSString *host = [self.url.host stringByReplacingOccurrencesOfString:@"." withString:@"/"];
    NSString *relativePath = self.url.relativePath;
    
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/images/%@%@", cachePath, host, relativePath]];
}

@end
