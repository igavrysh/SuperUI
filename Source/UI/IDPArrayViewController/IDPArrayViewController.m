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
#import "IDPFilteredUserArrayModel.h"
#import "IDPUserCell.h"
#import "IDPArrayView.h"
#import "IDPLoadingView.h"

#import "UITableView+IDPExtensions.h"

#import "IDPMacros.h"
#import "IDPCompilerMacros.h"

static NSString * const kIDPRemoveButtonText = @"Remove";

@interface IDPArrayViewController ()
@property (nonatomic, strong)   IDPArrayModel               *arrayModel;

- (void)filterDataUsingFilterString:(NSString *)filter;
- (void)reloadTableView;

@end

IDPViewControllerBaseViewProperty(IDPArrayViewController, IDPArrayView, arrayView);

@implementation IDPArrayViewController

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPArrayModel *)model {
    if ([super model] != model) {
        [super setModel:[[IDPFilteredUserArrayModel alloc] initWithArrayModel:model]];
        self.arrayModel = model;
        
        if (self.isViewLoaded) {
            self.rootView.model = self.model;
            
            [self.arrayModel load];
        }
    }
}

- (IDPArrayView *)arrayView {
    return (IDPArrayView *)self.rootView;
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
    IDPFilteredUserArrayModel *model = self.model;
    
    model.filter = filter;
}

- (void)reloadTableView {
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);

        [self.arrayView.tableView reloadData];
    });
}

#pragma mark -
#pragma mark IDPChangeableModelObserver

- (void)            model:(IDPArrayModel *)array
 didUpdateWithChangeModel:(IDPArrayChangeModel *)changeModel
{
    IDPPrintMethod;
    
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"presented model elem. count = %lu, actual count = %lu",
              (unsigned long)((IDPArrayModel *)self.model).count, self.arrayModel.count);
        
        [self.arrayView.tableView applyChangeModel:changeModel];
    });
}

#pragma mark -
#pragma mark IDPLoadableModelObserver

- (void)modelDidUpdate:(IDPArrayModel *)model {
    IDPPrintMethod;
    
    [self reloadTableView];
}

- (void)modelDidLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    [self reloadTableView];
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
    return ((IDPArrayModel *)self.model).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<IDPModelCell> *cell = [self cellForTable:tableView withIndexPath:indexPath];
    
    cell.model = self.model[indexPath.row];
    
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
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{    
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
    
    [self.arrayModel moveObjectToIndex:destinationIndexPath.row
                             fromIndex:sourceIndexPath.row];
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        IDPAsyncPerformInBackgroundQueue(^{
            id object = self.model[indexPath.row];
            
            [self.arrayModel removeObject:object];
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
