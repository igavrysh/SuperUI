//
//  IDPFBLoginViewController.m
//  SuperUI
//
//  Created by Ievgen on 9/26/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBLoginViewController.h"

@implementation IDPFBLoginViewController

#pragma mark -
#pragma mark Public Methods

- (IBAction)onLogin:(UIButton *)button {
    IDPFBLoginContext *context = [IDPFBLoginContext loginContextWithViewController:self];
    
    [context execute];
}
@end
