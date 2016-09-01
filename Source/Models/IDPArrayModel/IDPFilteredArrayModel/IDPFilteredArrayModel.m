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

- (void)filterArrayModel;

@end

@implementation IDPFilteredArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObjects:nil];
}

- (instancetype)initWithObjects:(NSArray *)objects {
    self = [super initWithObjects:objects];
    
    return self;
}

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        [_arrayModel removeObserver:self];
        
        _arrayModel = arrayModel;
        
        [arrayModel addObserver:self];
    }
}

#pragma mark - 
#pragma mark Accessors

- (NSArray *)objects {
    return [[self objects] copy];
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)isObjectEligible:(id)object {
    return YES;
}

- (void)filterArrayModel {
    IDPAsyncPerformInBackgroundQueue(^{
        NSArray *models = [self.arrayModel.objects filteredArrayUsingBlock:^BOOL(id object) {
            return [self isObjectEligible:object];
        }];
        
        [self substituteObjectsWithObjects:models];
        
        self.state = IDPLoadableModelLoaded;
    });
}

#pragma mark -
#pragma mark IDPChangeableModelObserver

- (void)            model:(IDPArrayModel *)array
    didUpdateWithUserInfo:(IDPArrayChangeModel *)changeModel
{
    IDPPrintMethod;
    
    self.state = IDPLoadableModelLoaded;
}

#pragma mark -
#pragma mark IDPLoadableModelObserver

- (void)modelDidLoad:(IDPArrayModel *)array {
    self.state = IDPLoadableModelLoaded;
}

- (void)modelWillLoad:(IDPArrayModel *)array {
    self.state = IDPLoadableModelLoading;
}

- (void)modelDidFailLoading:(IDPArrayModel *)array {
    self.state = IDPLoadableModelFailedLoading;
}


@end
