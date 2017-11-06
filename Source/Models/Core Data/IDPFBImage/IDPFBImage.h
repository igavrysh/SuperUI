//
//  IDPFBImage.h
//  SuperUI
//
//  Created by Ievgen on 10/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "IDPFBManagedObject.h"

@class IDPImageModel;

@interface IDPFBImage : IDPFBManagedObject <IDPObservableObject>
@property (nonatomic, strong, readonly)     NSURL           *url;
@property (nonatomic, strong, readonly)     IDPImageModel   *imageModel;

@end
