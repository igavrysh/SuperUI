//
//  IDPFBFriendsViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsViewController.h"

#import "IDPGCDQueue.h"
#import "IDPFBUser.h"
#import "IDPUserArrayModel.h"
#import "IDPFBLogoutContext.h"
#import "IDPFBFriendsContext.h"
#import "IDPFBFriendsView.h"
#import "IDPModelCell.h"
#import "IDPUserCell.h"
#import "IDPFBUserDetailsViewController.h"
#import "IDPFBFriendsArrayModel.h"

#import "UITableView+IDPExtensions.h"

#import "IDPContextHelpers.h"
#import "IDPMacros.h"

kIDPStringVariableDefinition(kIDPLogoutButtonTitle, @"Logout");

@interface IDPFBFriendsViewController ()
@property (nonatomic, strong)   IDPFBUser               *user;
@property (nonatomic, strong)   IDPFBLogoutContext      *logoutContext;
@property (nonatomic, strong)   IDPFBFriendsContext     *friendsContext;

- (void)loadUsers;
- (void)setupNavigationBar;
- (UITableViewCell<IDPModelCell> *)cellForTable:(UITableView *)tableView
                                  withIndexPath:(NSIndexPath *)indexPath;
- (void)pushDetailsViewContollerForUser:(IDPFBUser *)user;
- (void)reloadTableView;

@end

IDPViewControllerBaseViewProperty(IDPFBFriendsViewController, IDPFBFriendsView, friendsView);

@implementation IDPFBFriendsViewController

#pragma mark - Initializations and Deallocations

- (instancetype)initWithUser:(IDPFBUser *)user {
    self = [super init];
    
    self.user = user;
    
    self.friends = [[IDPFBFriendsArrayModel alloc] initWithContainerModel:user
                                                           arrayKeyPath:@"friends"];
    return self;
}

#pragma mark -
#pragma mark Accessors

IDPBaseViewGetterSynthesize(SUIView, rootView);

- (void)setFriends:(IDPFBFriendsArrayModel *)friends {
    if (_friends != friends) {
        [_friends removeObserverObject:self];
     
        _friends = friends;
        
        [friends addObserverObject:self];
        
        if (self.isViewLoaded) {
            self.rootView.model = self.friends;
        }
    }
}

- (void)setFriendsContext:(IDPFBFriendsContext *)friendsContext {
    IDPContextSetter(&_friendsContext, friendsContext);
}

- (void)setLogoutContext:(IDPFBLogoutContext *)logoutContext {
    IDPContextSetter(&_logoutContext, logoutContext);
}

#pragma mark -
#pragma mark Private

- (void)loadUsers {
    self.friendsContext = [IDPFBFriendsContext contextWithFBUser:self.user
                                                         friends:self.friends];
}

- (void)setupNavigationBar {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:kIDPLogoutButtonTitle
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(onLogout:)];
    self.navigationItem.leftBarButtonItem = button;
}

- (void)pushDetailsViewContollerForUser:(IDPFBUser *)user {
    //IDPFBUserDetailsViewController *controller = [IDPFBUserDetailsViewController new];
    //controller.model = user;
    
    //[self.navigationController pushViewController:controller animated:YES];
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
    });
}

#pragma mark -
#pragma mark View Lifecycle

- (IBAction)onLogout:(UIBarButtonItem *)button {
    IDPFBLogoutContext *logoutContext = [IDPFBLogoutContext contextWithModel:self.user];
    
    self.logoutContext = logoutContext;
    
    [logoutContext execute];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootView.model = self.friends;
    
    [self loadUsers];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rootView.model = self.friends;
    
    [self setupNavigationBar];
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
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<IDPModelCell> *cell = [self cellForTable:tableView withIndexPath:indexPath];
    
    cell.model = self.friends[indexPath.row];
    
    return cell;
}

- (BOOL)        tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushDetailsViewContollerForUser:self.friends[indexPath.row]];
}

@end
