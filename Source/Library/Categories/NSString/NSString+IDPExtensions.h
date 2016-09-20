//
//  NSString+IDPExtensions.h
//  Test
//
//  Created by Oleksa Korin on 4/15/15.
//  Copyright (c) 2015 Oleksa Korin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPExtensions)

// english
+ (instancetype)alphanumericAlphabet;

// arabian
+ (instancetype)numericAlphabet;

// english
+ (instancetype)lowercaseLetterAlphabet;

// english
+ (instancetype)capitalizedLetterAlphabet;

// english
+ (instancetype)letterAlphabet;

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

// returns string with english alphanumeric characters of random length
// of up to 30 with the class of receiver
+ (instancetype)randomString;

// returns string with english alphanumeric characters of length
// with the class of receiver
+ (instancetype)randomStringWithLength:(NSUInteger)length;

// returns string with characters from aplhabet of length
// with the class of receiver
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

- (instancetype)stringByAddingPercentEncodingWithAlphanumericCharSet;

- (instancetype)stringBySubstitutingSymbols:(NSDictionary *)dictionary;

- (NSArray *)symbols;

@end
