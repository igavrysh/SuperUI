//
//  SUIView.m
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIView.h"

@implementation SUIView

#pragma mark -
#pragma mark Class Methods

+ (SUIView *)viewWithFrame:(CGRect)frame {
    SUIView *view = [[self alloc] initWithFrame:frame];
    
    return view;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    return self;
}

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
#pragma mark IDPLoadableModelObserver

- (void)modelDidLoad:(IDPLoadableModel *)model {
    [self hideLoadingView];
}

- (void)modelWillLoad:(IDPLoadableModel *)model {
    [self showLoadingView];
}

@end
