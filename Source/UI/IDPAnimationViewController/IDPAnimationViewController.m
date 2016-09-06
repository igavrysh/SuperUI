//
//  IDPAnimationViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/5/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAnimationViewController.h"

#import "IDPAnimationView.h"

#import "IDPMacros.h"

IDPViewControllerBaseViewProperty(IDPAnimationViewController, IDPAnimationView, animationView);

@interface IDPAnimationViewController ()

@end

@implementation IDPAnimationViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onPlayButton:(id)sender {
    self.animationView.running = YES;
}

- (IBAction)onStopButton:(id)sender {
    self.animationView.running = NO;
}

@end
