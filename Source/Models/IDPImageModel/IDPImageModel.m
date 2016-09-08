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

- (void)load {
    @synchronized(self) {
        NSUInteger state = self.state;
        
        if (IDPImageModelLoading == state || IDPImageModelLoaded == state) {
            [self notifyOfStateChange:state];
            return;
        }
        
        self.state = IDPImageModelLoading;
    }
    
    IDPWeakify(self);
    IDPAsyncPerformInBackgroundQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        
        self.image = [UIImage imageWithContentsOfFile:[self.url path]];
        
        @synchronized(self) {
            self.state = self.image ? IDPImageModelLoaded : IDPImageModelFailedLoading;
        }
    });
}

- (void)dump {
    self.image = nil;
    self.state = IDPImageModelUnloaded;
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPImageModelUnloaded:
            return @selector(imageModelDidUnload:);
            
        case IDPImageModelLoading:
            return @selector(imageModelWillLoad:);
            
        case IDPImageModelLoaded:
            return @selector(imageModelDidLoad:);
            
        case IDPImageModelFailedLoading:
            return @selector(imageModelDidFailLoading:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
