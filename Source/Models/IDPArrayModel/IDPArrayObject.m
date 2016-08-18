//
//  IDPArrayItem.m
//  SuperUI
//
//  Created by Ievgen on 8/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayObject.h"

#import "IDPImageModel.h"

@interface IDPArrayObject ()
@property (nonatomic, strong)   NSString        *name;
@property (nonatomic, strong)   IDPImageModel   *imageModel;

@end

@implementation IDPArrayObject

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithName:(NSString *)name url:(NSURL *)url {
    return [[self alloc] initWithName:name url:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url  {
    self.name = name;
    self.imageModel = [[IDPImageModel alloc] initWithURL:url];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)save {
}

- (void)load {
}

@end
