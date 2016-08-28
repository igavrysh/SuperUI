//
//  IDPGCDQueue.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPGCDQueue.h"

void IDPAsyncPerformInBackgroundQueue(IDPGCDExecutionBlock block) {
    IDPAsyncPerformInQueue(IDPQueuePriorityTypeBackground, block);
}

void IDPSyncPerformInBackgoundQueue(IDPGCDExecutionBlock block) {
    IDPSyncPerformInQueue(IDPQueuePriorityTypeBackground, block);
}

void IDPAsyncPerformInQueue(IDPQueuePriorityType type, IDPGCDExecutionBlock block) {
    dispatch_async(IDPGetGlobalQueueWithType(type), block);
}

void IDPSyncPerformInQueue(IDPQueuePriorityType type, IDPGCDExecutionBlock block) {
    dispatch_sync(IDPGetGlobalQueueWithType(type), block);
}

void IDPAsyncPerformInMainQueue(IDPGCDExecutionBlock block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void IDPSyncPerformInMainQueue(IDPGCDExecutionBlock block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

dispatch_queue_t IDPGetGlobalQueueWithType(IDPQueuePriorityType type) {
    return dispatch_get_global_queue(type, 0);
}
