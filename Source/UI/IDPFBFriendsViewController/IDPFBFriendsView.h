//
//  IDPFBFriendsView.h
//  SuperUI
//
//  Created by Ievgen on 9/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIView.h"

#import "YALSunnyRefreshControl.h"

@interface IDPFBFriendsView : SUIView
@property (nonatomic, strong)   IBOutlet UITableView        *tableView;

- (void)setupRefreshControl;

- (void)startAnimation;
- (void)stopAnimation;

@end
