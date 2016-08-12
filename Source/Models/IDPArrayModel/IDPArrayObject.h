//
//  IDPArrayItem.h
//  SuperUI
//
//  Created by Ievgen on 8/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDPArrayObject : NSObject
@property (nonatomic, readonly) NSString    *string;
@property (nonatomic, readonly) UIImage     *image;

- (void)save;
- (void)load;

@end
