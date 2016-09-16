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

#import "IDPDispatchMacros.h"

@interface IDPImageModel ()

+ (NSMapTable *)cluster;

+ (void)registerClass:(Class)class forURL:(NSURL *)url;

+ (Class)classForURL:(NSURL *)url;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (id)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

+ (NSMapTable *)cluster {
    IDPReturnAfterSettingVariableWithBlockOnce(^{
        return [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality
                                     valueOptions:NSPointerFunctionsWeakMemory];
    });
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithURL:(NSURL *)url {
    self = nil;
    
    Class class = [IDPImageModel classForURL:url];
    
    if (!class) {
        class = url.isFileURL ? [IDPLocalImageModel class] : [IDPInternetImageModel class];
    }
    
    return [class imageWithURL:url];
}

#pragma mark - 
#pragma mark Private Methods

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

@end
