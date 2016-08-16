//
//  IDPArrayObjectCell.m
//  SuperUI
//
//  Created by Ievgen on 8/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayObjectCell.h"

#import "IDPImageView.h"
#import "IDPArrayObject.h"

@implementation IDPArrayObjectCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark -
#pragma mark Accessors

- (void)setObject:(IDPArrayObject *)object {
    if (_object != object) {
        _object = object;
        
        [self fillWithObject:object];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithObject:(IDPArrayObject *)object {
    self.nameLabel.text = self.object.name;
    self.userImageView.imageModel = object.imageModel;
    
    NSLog(@"");
}

@end
