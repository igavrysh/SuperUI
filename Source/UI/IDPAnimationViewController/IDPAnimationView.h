//
//  IDPAnimationView.h
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IDPSquarePosition) {
    IDPSquarePositionTopLeft,
    IDPSquarePositionTopRight,
    IDPSquarePositionBottomRight,
    IDPSquarePositionBottomLeft,
    IDPSquarePositionsCount,
    IDPSquarePositionDefault = IDPSquarePositionTopLeft
};

@interface IDPAnimationView : UIView
@property (nonatomic, assign)                   IDPSquarePosition   squarePosition;
@property (nonatomic, strong)                   IBOutlet UIView     *square;
@property (nonatomic, assign, getter=isRunning) BOOL                running;

@end
