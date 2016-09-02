//
//  SUIViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIViewController.h"

#import "SUIView.h"

#import "IDPMacros.h"

IDPViewControllerBaseViewProperty(SUIViewController, rootView, SUIView)

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

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rootView.model = self.model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootView.model = self.model;
    
    [self.model load];
}

@end
