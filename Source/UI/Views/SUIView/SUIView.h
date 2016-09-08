//
//  SUIView.h
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

#import "IDPModel.h"

@interface SUIView : IDPView <IDPLoadableModelObserver>
@property (nonatomic, strong) IDPModel  *model;

@end
