//
//  IDPAnimationView.h
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    IDPSquarePositionTopLeft,
    IDPSquarePositionTopRight,
    IDPSquarePositionBottomRight,
    IDPSquarePositionBottomLeft
} IDPSquarePosition;

static const NSUInteger IDPSquarePositionsCount = 4;

static const NSUInteger IDPSquarePositionDefault = IDPSquarePositionTopRight;

@interface IDPAnimationView : UIView
@property (nonatomic, assign)   IDPSquarePosition   squarePosition;
@property (nonatomic, strong)   IBOutlet UIView     *square;

- (void)play;
- (void)stop;

@end
