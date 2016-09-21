//
//  SUIView.m
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "SUIView.h"

#import "IDPGCDQueue.h"
#import "IDPMacros.h"

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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    IDPPrintMethod;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    IDPPrintMethod;
    
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
#pragma mark IDPModelObserver

- (void)modelDidLoad:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = NO;
    });
}

- (void)modelWillLoad:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = YES;
    });
}

- (void)modelDidFailLoading:(IDPModel *)model {
    IDPAsyncPerformInMainQueue(^{
        self.loadingViewVisible = NO;
    });
}

@end
