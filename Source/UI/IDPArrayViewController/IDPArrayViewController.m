//
//  IDPArrayViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayViewController.h"

#import "IDPGCDQueue.h"
#import "IDPCompilerMacros.h"
#import "IDPArrayView.h"
#import "IDPUserCell.h"
#import "IDPUser.h"
#import "IDPArrayModel.h"
#import "IDPArrayChangeModel.h"
#import "IDPMacros.h"

#import "UITableView+IDPExtensions.h"

NSString * const kIDPRemoveButtonText = @"Remove";

IDPViewControllerBaseViewProperty(IDPArrayViewController, arrayView, IDPArrayView)

@interface IDPArrayViewController ()

@end

@implementation IDPArrayViewController

#pragma mark -
#pragma mark Accessors

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        [_arrayModel removeObserver:self];
        
        _arrayModel = arrayModel;
        
        [arrayModel addObserver:self];
        
        if (self.isViewLoaded) {
            [self.arrayModel load];
        }
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

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -
#pragma mark Private Methods

#pragma mark -
#pragma mark IDPArrayModelObserver

- (void)        arrayModel:(IDPArrayModel *)array
  didUpdateWithChangeModel:(IDPArrayChangeModel *)changeModel;
{
    IDPPrintMethod;
    
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        [self.arrayView.tableView applyChangeModel:changeModel];
    });
}

- (void)arrayModelDidLoad:(IDPArrayModel *)array
{
    IDPPrintMethod;
    
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        [self.arrayView.tableView reloadData];
    });
}

- (void)arrayModelWillLoad:(IDPArrayModel *)array
{
    IDPPrintMethod;
    
}

- (void)arrayModelDidFailLoading:(IDPArrayModel *)array
{
    IDPPrintMethod;
    
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
    UITableViewCell<IDPModelCell> *cell = [self cellForTable:tableView withIndexPath:indexPath];
    
    cell.model = self.arrayModel[indexPath.row];
    
    return cell;
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

- (NSString *)                              tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kIDPRemoveButtonText;
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
        [self.arrayModel performBlockWithNotification:^{
            [self.arrayModel removeObjectAtIndex:indexPath.row];
         }];
    }
}


@end
