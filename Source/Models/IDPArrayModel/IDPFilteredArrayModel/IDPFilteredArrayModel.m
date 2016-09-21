//
//  IDPFilteredArrayModel.m
//  SuperUI
//
//  Created by Ievgen on 9/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFilteredArrayModel.h"

#import "IDPGCDQueue.h"
#import "IDPArrayChangeModel.h"

#import "NSArray+IDPArrayEnumerator.h"
#import "IDPArrayModel+IDPExtensions.h"

#import "IDPMacros.h"

@interface IDPFilteredArrayModel ()
@property (nonatomic, strong)   IDPArrayModel   *arrayModel;

@end

@implementation IDPFilteredArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithArrayModel:nil];
}

- (instancetype)initWithArrayModel:(IDPArrayModel *)arrayModel {
    self = [super init];
    self.arrayModel = arrayModel;
    
    return self;
}

#pragma mark - 
#pragma mark Accessors

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        [_arrayModel removeObserver:self];
        
        _arrayModel = arrayModel;
        
        [arrayModel addObserver:self];
    }
}

- (NSPredicate *)predicate {
    return nil;
}

#pragma mark -
#pragma mark Public Methods

- (void)performFiltering {
    IDPAsyncPerformInBackgroundQueue(^{
        NSArray *filteredObjects = [self.arrayModel.objects filteredArrayUsingPredicate:self.predicate];
        
        [self substituteObjectsWithObjects:filteredObjects];
        
        [self performBlockWithoutNotification:^{
            self.state = IDPArrayModelDidUpdate;
        }];
        
        [self notifyOfStateChange:IDPArrayModelDidUpdate];
    });
}

- (void)load {
    [self.arrayModel load];
}

- (void)save {
    [self.arrayModel save];
}

#pragma mark -
#pragma mark IDPChangeableModelObserver

- (void)            model:(IDPArrayModel *)model
 didUpdateWithChangeModel:(IDPArrayChangeModel *)changeModel
{
    IDPPrintMethod;
    
    [self applyChangeModel:changeModel];
}

- (void)modelDidUpdate:(IDPArrayModel *)model {
    IDPPrintMethod;
    
    [self performFiltering];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    [self substituteObjectsWithObjects:self.arrayModel.objects];
    
    self.state = IDPModelDidLoad;
}

- (void)modelWillLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    self.state = IDPModelWillLoad;
}

- (void)modelDidFailLoading:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    self.state = IDPModelDidFailLoading;
}

@end
