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

IDPBaseViewGetterSynthesize(SUIView, rootView);

- (void)setModel:(IDPModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        
        [model addObserverObject:self];
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
    
    [(IDPModel *)self.model load];
}

@end
