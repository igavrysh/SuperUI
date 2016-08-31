//
//  IDPArrayViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayViewController.h"

#import "IDPGCDQueue.h"
#import "IDPUser.h"
#import "IDPArrayModel.h"
#import "IDPArrayChangeModel.h"
#import "IDPUserCell.h"
#import "IDPArrayView.h"
#import "IDPLoadingView.h"

#import "UITableView+IDPExtensions.h"

#import "IDPMacros.h"
#import "IDPCompilerMacros.h"

NSString * const kIDPRemoveButtonText = @"Remove";

IDPViewControllerBaseViewProperty(IDPArrayViewController, arrayView, IDPArrayView)

@interface IDPArrayViewController ()
@property (nonatomic, strong)   IDPArrayModel   *filteredModel;

- (void)filterDataUsingFilterString:(NSString *)filter;

@end

@implementation IDPArrayViewController

@synthesize arrayModel = _arrayModel;

#pragma mark -
#pragma mark Accessors

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        [_arrayModel removeObserver:self];
        [_filteredModel removeObserver:self];
        
        _arrayModel = arrayModel;
        self.filteredModel = nil;
        
        if (self.isViewLoaded) {
            [self.arrayModel load];
        }
    }
}

- (IDPArrayModel *)arrayModel {
    return self.arrayView.filtered && _filteredModel ? _filteredModel : _arrayModel;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.arrayView.model = self.arrayModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.arrayModel addObservers:@[self]];
    
    self.arrayView.model = self.arrayModel;
    
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

- (void)filterDataUsingFilterString:(NSString *)filter {
    IDPWeakify(self);
    
    IDPAsyncPerformInBackgroundQueue(^{
        IDPStrongify(self);
        
        if (![filter isEqualToString:@""]) {
            self.arrayView.filtered = YES;
            
            self.filteredModel = [_arrayModel filteredArrayUsingFilterString:filter];
        } else {
            self.arrayView.filtered = NO;
            
            self.filteredModel = nil;
        }
        
        IDPAsyncPerformInMainQueue(^{
            [self.arrayView.tableView reloadData];
        });
    });
}

#pragma mark -
#pragma mark IDPChangeableModelObserver

- (void)            model:(IDPArrayModel *)array
    didUpdateWithUserInfo:(IDPArrayChangeModel *)changeModel
{
    IDPPrintMethod;
    
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        [self.arrayView.tableView applyChangeModel:changeModel];
    });
}

#pragma mark -
#pragma mark IDPLoadableModelObserver

- (void)modelDidLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        [self.arrayView.tableView reloadData];
    });
}

- (void)modelWillLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
}

- (void)modelDidFailLoading:(IDPArrayModel *)array {
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
    return self.arrayView.canMoveRows;
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

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        
        IDPAsyncPerformInBackgroundQueue(^{
            NSUInteger index = indexPath.row;
            
            if (self.arrayView.isFiltered) {
                id object = _filteredModel[index];
                [_filteredModel removeObjectAtIndex:index];
                [_arrayModel performBlockWithoutNotification:^{
                    [_arrayModel removeObject:object];
                }];
            } else {
                [self.arrayModel removeObjectAtIndex:index];
            }
        });
    }
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    IDPPrintMethod;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    IDPPrintMethod;
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    IDPPrintMethod;
    [self filterDataUsingFilterString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.arrayView endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.arrayView endEditing:YES];
}

@end
