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
#import "IDPObjectsCache.h"

#import "IDPDispatchMacros.h"

@interface IDPImageModel ()
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;

+ (NSMapTable *)cluster;

+ (void)registerClass:(Class)class forURL:(NSURL *)url;

+ (Class)classForURL:(NSURL *)url;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (id)imageWithURL:(NSURL *)url {
    IDPImageModel *image = [[IDPObjectsCache cache] objectForKey:url];
    
    if (image) {
        return image;
    }
    
    Class class = [IDPImageModel classForURL:url];
    
    if (!class) {
        class = url.isFileURL ? [IDPLocalImageModel class] : [IDPInternetImageModel class];
    }
    
    image = [[class alloc] initWithURL:url];
    
    [[IDPObjectsCache cache] setObject:image forKey:image.url];
    
    return image;
}

+ (NSMapTable *)cluster {
    IDPReturnAfterSettingVariableWithBlockOnce(^{
        return [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality
                                     valueOptions:NSPointerFunctionsWeakMemory];
    });
}

+ (void)registerClass:(Class)class forURL:(NSURL *)url {
    @synchronized(self) {
        [[self cluster] setObject:class forKey:url];
    }
}

+ (Class)classForURL:(NSURL *)url {
    @synchronized(self) {
        return [[self cluster] objectForKey:url];
    }
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    [self performLoadingWithURL:self.url
                completionBlock:^(UIImage *image, NSError *error) {
                    self.image = image;
                    
                    self.state = !self.image || error ? IDPModelDidFailLoading : IDPModelDidLoad;
                }];
}

- (void)performLoadingWithURL:(NSURL *)url
              completionBlock:(IDPImageLoadingCompletionBlock)block
{
    IDPBlockPerform(block, nil, nil);
}

#pragma mark -
#pragma mark Private

#pragma mark -
#pragma mark Private Methods

- (void)dump {
    self.image = nil;
    self.state = IDPModelDidUnload;
}

@end
