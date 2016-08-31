//
//  SUIViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

@implementation SUIViewController

#pragma mark - 
#pragma mark Accessors

- (void)setModel:(IDPModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        
        [model addObserver:self];
    }
}
@end
