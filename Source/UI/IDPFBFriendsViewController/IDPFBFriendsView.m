//
//  IDPFBFriendsView.m
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBFriendsView.h"

@interface IDPFBFriendsView ()
@property (nonatomic, strong)   YALSunnyRefreshControl      *sunnyRefreshControl;


@end

@implementation IDPFBFriendsView

#pragma mark -
#pragma mark Public Methods

- (void)setupRefreshControl {
    self.sunnyRefreshControl = [YALSunnyRefreshControl new];
    [self.sunnyRefreshControl addTarget:self
                                 action:@selector(sunnyControlDidStartAnimation)
                       forControlEvents:UIControlEventValueChanged];
    [self.sunnyRefreshControl attachToScrollView:self.tableView];
}

- (void)startAnimation {
    [self.sunnyRefreshControl beginRefreshing];
}

- (void)sunnyControlDidStartAnimation {
}

- (void)stopAnimation {
    [self.sunnyRefreshControl endRefreshing];
}

@end
