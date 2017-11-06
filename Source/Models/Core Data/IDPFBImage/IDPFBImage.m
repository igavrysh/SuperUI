//
//  IDPFBImage.m
//  SuperUI
//
//  Created by Ievgen on 10/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBImage.h"

#import "IDPImageModel.h"

@implementation IDPFBImage

@dynamic imageModel;
@dynamic url;

#pragma mark -
#pragma mark Accessores

- (NSURL *)url {
    return [NSURL URLWithString:self.managedObjectID];
}

- (IDPImageModel *)imageModel {
    IDPImageModel *model = [IDPImageModel imageWithURL:self.url];
    
    return model;
}

@end
