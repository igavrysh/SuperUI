//
//  IDPView.m
//  SuperUI
//
//  Created by Ievgen on 8/29/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPView.h"

#import "IDPLoadingView.h"

@interface IDPView ()
@property (nonatomic, retain)   IDPLoadingView  *loadingView;

- (void)initSubviews;

@end

@implementation IDPView

#pragma mark -
#pragma mark Class Methods

+ (IDPView *)viewWithFrame:(CGRect)frame {
    IDPView *view = [[self alloc] initWithFrame:frame];
    
    return view;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self initSubviews];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self initSubviews];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)showLoadingView {
    [self.loadingView setVisible:YES animated:YES];
}

- (void)hideLoadingView {
    [self.loadingView setVisible:NO animated:YES];
}

#pragma mark - 
#pragma mark Private Methods

- (void)initSubviews {
    IDPLoadingView *loadingView = [[IDPLoadingView alloc] initWithFrame:self.bounds];
    loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
        | UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleRightMargin
        | UIViewAutoresizingFlexibleTopMargin
        | UIViewAutoresizingFlexibleHeight;
    
    self.loadingView = loadingView;
}


@end
