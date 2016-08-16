//
//  IDPImageModel.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModel.h"
#import "IDPImageModelDispatcher.h"
#import "IDPMacro.h"

@interface IDPImageModel ()
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;
@property (nonatomic, strong)   NSOperation *operation;

- (NSOperation *)imageLoadingOperation;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        if (operation) {
            IDPImageModelDispatcher *dispatcher = [IDPImageModelDispatcher sharedDispatcher];
            [dispatcher.queue addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)load {
    @synchronized(self) {
        if (IDPImageModelLoading == self.state) {
            return;
        }
        
        if (IDPImageModelLoaded == self.state) {
            [self notifyOfStateChange:IDPImageModelLoaded];
            return;
        }
        
        self.state = IDPImageModelLoading;
    }
    
    self.operation = [self imageLoadingOperation];
}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = IDPImageModelUnloaded;
}

#pragma mark -
#pragma mark Private

- (NSOperation *)imageLoadingOperation {
    IDPWeakify(self);
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        IDPStrongifyAndReturnIfNil(self);
        self.image = [UIImage imageWithContentsOfFile:[self.url path]];
    }];
    
    operation.completionBlock = ^{
        IDPStrongify(self);
        @synchronized(self) {
            self.state = self.image ? IDPImageModelLoaded : IDPImageModelFailedLoading;
        }
    };
    
    return operation;
}

@end
