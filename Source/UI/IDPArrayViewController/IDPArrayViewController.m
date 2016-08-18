//
//  IDPArrayViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayViewController.h"

#import "IDPMacro.h"
#import "IDPArrayView.h"
#import "IDPArrayObjectCell.h"
#import "IDPArrayModel.h"

#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPArrayViewController, arrayView, IDPArrayView)

@interface IDPArrayViewController ()

@end

@implementation IDPArrayViewController

#pragma mark -
#pragma mark Accessors

- (void)setArray:(IDPArrayModel *)array {
    if (_array != array) {
        _array = array;
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.arrayView.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDPArrayObjectCell *cell = [tableView cellWithClass:[IDPArrayObjectCell class]];
    
    cell.object = self.array[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(IDPArrayObjectCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
