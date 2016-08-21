//
//  IDPGCDQueue.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IDPGCDExecutionBlock)(void);

typedef enum {
    IDPQueuePriorityTypeHigh        = DISPATCH_QUEUE_PRIORITY_HIGH,
    IDPQueuePriorityTypeDefault     = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    IDPQueuePriorityTypeLow         = DISPATCH_QUEUE_PRIORITY_LOW,
    IDPQueuePriorityTypeBackground  = DISPATCH_QUEUE_PRIORITY_BACKGROUND
} IDPQueuePriorityType;

void IDPAsyncPerformInBackgroundQueue(IDPGCDExecutionBlock block);
void IDPSyncPerformInBackgoundQueue(IDPGCDExecutionBlock block);

void IDPAsyncPerformInQueue(IDPQueuePriorityType type, IDPGCDExecutionBlock block);
void IDPSyncPerformInQueue(IDPQueuePriorityType type, IDPGCDExecutionBlock block);

void IDPAsyncPerformInMainQueue(IDPGCDExecutionBlock block);
void IDPSyncPerformInMainQueue(IDPGCDExecutionBlock block);

dispatch_queue_t IDPGetGlobalQueueWithType(IDPQueuePriorityType type);
