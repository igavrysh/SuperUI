//
//  IDPImageModel.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModel.h"

#import "IDPGCDQueue.h"

#import "IDPMacros.h"

@interface IDPImageModel ()
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;

- (void)dump;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    self.image = [UIImage imageWithContentsOfFile:[self.url path]];
    
    self.state = IDPModelDidLoad;
}

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

@end
