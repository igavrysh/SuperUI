//
//  IDPContext.m
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPContext.h"

#import "IDPModel.h"
#import "IDPGCDQueue.h"

@interface IDPContext ()
@property (nonatomic, strong)   IDPModel    *model;

@end

@implementation IDPContext

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)contextWithModel:(id)model {
    return [[self alloc] initWithModel:model];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithModel:(id)model {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark - 
#pragma mark Public Methods

- (void)execute {
    IDPModel *model = self.model;
    
    @synchronized(model) {
        NSUInteger state = model.state;
        if ([self contextDidExecuteState] == state
            || [self contextExecutingState] == state)
        {
            [model notifyOfStateChange:state];
            
            return;
        }
        
        model.state = [self contextExecutingState];
        
        IDPAsyncPerformInBackgroundQueue(^{
            [self load];
        });
    }
}

- (void)cancel {
}

- (NSUInteger)contextExecutingState {
    return IDPModelWillLoad;
}

- (NSUInteger)contextDidExecuteState {
    return IDPModelDidLoad;
}

- (void)load {
    [self.model load];
}

@end
