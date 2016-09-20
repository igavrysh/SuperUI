//
//  NSURLSession+IDPExtensions.m
//  SuperUI
//
//  Created by Ievgen on 9/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSURLSession+IDPExtensions.h"

#import "IDPDispatchMacros.h"
#import "IDPBlockTypes.h"

@implementation NSURLSession (IDPExtensions)

+ (instancetype)sharedDefaultSession {
    IDPFactoryBlock block = ^{
        return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    };
    
    IDPReturnAfterSettingVariableWithBlockOnce(block);
}

@end
