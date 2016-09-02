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
        
        self.state = IDPChangeableModelReloaded;
    });
}

- (void)load {
    [self.arrayModel load];
}

#pragma mark -
#pragma mark IDPChangeableModelObserver

- (void)            model:(IDPArrayModel *)array
    didUpdateWithUserInfo:(IDPArrayChangeModel *)changeModel
{
    IDPPrintMethod;
    
    [self performBlockWithoutNotification:^{
        self.state = IDPChangeableModelUpdated;
    }];
    
    [self notifyOfStateChange:IDPChangeableModelUpdated withObject:changeModel];
}

- (void)modelWillReload:(IDPArrayModel *)model {
    IDPPrintMethod;
    
    self.state = IDPChangeableModelReloading;
}

- (void)modelDidReload:(IDPArrayModel *)model {
    IDPPrintMethod;
    
    self.state = IDPChangeableModelReloaded;
}

#pragma mark -
#pragma mark IDPLoadableModelObserver

- (void)modelDidLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    self.state = IDPLoadableModelLoaded;
}

- (void)modelWillLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    self.state = IDPLoadableModelLoading;
}

- (void)modelDidFailLoading:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    self.state = IDPLoadableModelFailedLoading;
}

@end
