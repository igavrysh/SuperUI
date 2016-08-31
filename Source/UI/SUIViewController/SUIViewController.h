//
//  SUIViewController.h
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPModel.h"

@interface SUIViewController : UIViewController <IDPLoadableModelObserver>
@property (nonatomic, strong) IDPModel *model;


@end
