//
//  IDPImageModelDispatcher.m
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPImageModelDispatcher.h"

@interface IDPImageModelDispatcher ()
@property (nonatomic, strong)   NSOperationQueue    *queue;

- (void)initQueue;

@end

@implementation IDPImageModelDispatcher

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedDispatcher {
    static dispatch_once_t onceToken;
    static id dispatcher = nil;
    dispatch_once(&onceToken, ^{
        dispatcher = [self new];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queue = nil;
}

//static id dispatcher = nil;
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
//        dispatcher = [self allocWithZone:zone];
//    });
//    
//    return dispatcher;
//}
//
//- (instancetype)init{
//    static dispatch_once_t onceToken;
//    
//    __block id object = self;
//    dispatch_once(&onceToken, ^{
//        object = [super init];
//        if (object) {
//            [object initQueue];
//        }
//    });
//    
//    return object;
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

@end
