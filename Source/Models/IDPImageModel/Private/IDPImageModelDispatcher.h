//
//  IDPImageModelDispatcher.h
//  iOSProject
//
//  Created by Ievgen on 8/8/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPImageModelDispatcher : NSObject
@property (nonatomic, readonly) NSOperationQueue    *queue;

+ (instancetype)sharedDispatcher;

@end
