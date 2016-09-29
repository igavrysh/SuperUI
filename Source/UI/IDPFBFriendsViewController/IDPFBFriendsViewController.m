//
//  IDPFBFriendsViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsViewController.h"

#import "IDPGCDQueue.h"
#import "IDPUser.h"
#import "IDPUserArrayModel.h"
#import "IDPFBLogoutContext.h"
#import "IDPFBFriendsContext.h"
#import "IDPFBFriendsView.h"
#import "IDPModelCell.h"
#import "IDPUserCell.h"

#import "UITableView+IDPExtensions.h"

#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPLogoutButtonTitle, @"Logout");

@interface IDPFBFriendsViewController ()
@property (nonatomic, strong) IDPUser               *user;
@property (nonatomic, strong) IDPFBLogoutContext    *logoutContext;

- (void)loadUsers;
- (void)setupNavigationBar;
- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath;

@end

IDPViewControllerBaseViewProperty(IDPFBFriendsViewController, IDPFBFriendsView, friendsView);

@implementation IDPFBFriendsViewController

#pragma mark - Initializations and Deallocations

- (instancetype)initWithUser:(IDPUser *)user {
    self = [super init];
    
    self.user = user;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(IDPArrayModel *)model {
    if ([super model] != model) {
        [super setModel:model];
        
        if (self.isViewLoaded) {
            self.rootView.model = self.model;
        }
    }
}

#pragma mark -
#pragma mark Private

- (void)loadUsers {
    self.model = [IDPArrayModel new];
    
    IDPFBContext *context = [IDPFBFriendsContext contextWithUser:self.user
                                                         friends:self.model];
    [context execute];
}

- (void)setupNavigationBar {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:kIDPLogoutButtonTitle
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(onLogout:)];
    self.navigationItem.leftBarButtonItem = button;
}

- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellWithClass:[IDPUserCell class]];
}

- (void)reloadTableView {
    IDPWeakify(self);
    IDPAsyncPerformInMainQueue(^{
        IDPStrongifyAndReturnIfNil(self);
        
        [self.friendsView.tableView reloadData];
        
        //??? Investigate why it happens
        //self.friendsView.loadingViewVisible = NO;
    });
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    
}

- (IBAction)onLogout:(UIBarButtonItem *)button {
    IDPFBLogoutContext *logoutContext = [IDPFBLogoutContext contextWithModel:self.user];
    
    self.logoutContext = logoutContext;
    
    [logoutContext execute];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self loadUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IDPArrayModelObserver

- (void)modelDidLoad:(IDPArrayModel *)array {
    IDPPrintMethod;
    
    [self reloadTableView];
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
#pragma mark UITableViewDataSource

- (BOOL)        tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
