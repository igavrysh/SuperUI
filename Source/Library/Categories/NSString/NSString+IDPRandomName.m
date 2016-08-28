//
//  NSString+IDPRandomName.m
//  iOSProject
//
//  Created by Ievgen on 7/31/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSString+IDPRandomName.h"

#import "NSString+IDPExtensions.h"

static const NSUInteger IDPRandomNameLength = 10;

@implementation NSString (IDPRandomName)

+ (instancetype)randomName {
    NSString *alphabet = [self lowercaseLetterAlphabet];
    
    return [[NSString randomStringWithLength:IDPRandomNameLength alphabet:alphabet] capitalizedString];
    
}

@end
