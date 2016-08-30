//
//  IDPChangeableModel.m
//  SuperUI
//
//  Created by Ievgen on 8/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPChangeableModel.h"

@implementation IDPChangeableModel

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPChangeableModelUpdated:
            return @selector(model:didUpdateWithUserInfo:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
