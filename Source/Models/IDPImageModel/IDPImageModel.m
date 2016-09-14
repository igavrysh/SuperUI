//
//  IDPImageModel.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPLocalImageModel.h"
#import "IDPInternetImageModel.h"

@interface IDPImageModel ()

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (id)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithURL:(NSURL *)url {
    self = nil;
    
    Class class = url.isFileURL ? [IDPLocalImageModel class] : [IDPInternetImageModel class];
    
    return [class imageWithURL:url];
}

@end
