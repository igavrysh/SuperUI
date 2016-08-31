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
#import "IDPCompilerMacros.h"

IDPViewControllerBaseViewProperty(SUIViewController, view, SUIView)

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
#pragma mark Public Methods

- (Class)viewControllerClass {
    return [SUIViewController class];
}

- (Class)viewClass {
    return [SUIView class];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view.model = self.model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.model = self.model;
    
    [self.model load];
}

@end
