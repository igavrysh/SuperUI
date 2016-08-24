//
//  IDPArrayViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayViewController.h"

#import "IDPGCDQueue.h"
#import "IDPMacros.h"
#import "IDPCompilerMacros.h"
#import "IDPArrayView.h"
#import "IDPUserCell.h"
#import "IDPUser.h"
#import "IDPArrayModel.h"
#import "IDPBlockObservationController.h"
#import "IDPArrayChangeModel.h"

#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPArrayViewController, arrayView, IDPArrayView)

@interface IDPArrayViewController ()
@property (nonatomic, strong)                               IDPBlockObservationController   *observer;

- (void)prepareObserver:(IDPBlockObservationController *)observer;

@end

@implementation IDPArrayViewController

#pragma mark -
#pragma mark Accessors

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        _arrayModel = arrayModel;
        
        self.observer = [_arrayModel blockObservationControllerWithObserver:self];
        
        if (self.isViewLoaded) {
            [self.arrayModel load];
        }
    }
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.arrayModel load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Public Methods

- (id<IDPModelCell>)cellForTable:(UITableView *)tableView
                   withIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellWithClass:[IDPUserCell class]];
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self);
    
    id handler = ^(IDPBlockObservationController *controller, IDPArrayChangeModel *changeModel) {
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"Model Updated");
        
        IDPSyncPerformInMainQueue(^{
            [self.arrayView applyChangeModel:changeModel];
        });
    };
    
    [observer setHandler:handler forState:IDPArrayModelUpdated];
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"Model Loaded");
        
        IDPSyncPerformInMainQueue(^{
            [self.arrayView reload];
        });
    };
    
    [observer setHandler:handler forState:IDPArrayModelLoaded];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return self.arrayModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<IDPModelCell> cell = [self cellForTable:tableView withIndexPath:indexPath];
    
    cell.model = self.arrayModel[indexPath.row];
    
    return (UITableViewCell *)cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(IDPUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)onEditButton:(id)sender {
    self.arrayView.editing = !self.arrayView.editing;
}

- (IBAction)onAddButton:(id)sender {
    [self.arrayModel insertObject:[IDPUser user] atIndex:0];
}


- (BOOL)        tableView:(UITableView *)tableView
    canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 
#pragma mar UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)                        tableView:(UITableView *)tableview
   shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (BOOL)        tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)    tableView:(UITableView *)tableView
   moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"from row: %ld to row: %ld", sourceIndexPath.row, (long)destinationIndexPath.row);
    
    [self.arrayModel performBlockWithoutNotification:^{
        [self.arrayModel moveObjectToIndex:destinationIndexPath.row
                                 fromIndex:sourceIndexPath.row];
    }];
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /* [self.arrayModel performBlockWithNotification:^{
         [self.collection removeObjectAtIndex:indexPath.row];
         }];*/
    }
}


@end
