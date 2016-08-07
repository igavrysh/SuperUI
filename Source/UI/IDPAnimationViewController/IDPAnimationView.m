//
//  IDPAnimationView.m
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAnimationView.h"

static NSTimeInterval IDPDuration   = 1.5;
static NSTimeInterval IDPDealay     = 0.3;

@interface IDPAnimationView ()
@property (nonatomic, assign)                   CGPoint *positions;
@property (nonatomic, assign, getter=isRunning) BOOL    running;

- (void)setUpSquarePositions;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL finished))completionHandler;

- (void)animate;

@end

@implementation IDPAnimationView

#pragma mark -
#pragma mart Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpSquarePositions];
    
    [self setSquarePosition:IDPSquarePositionDefault];
}

- (void)dealloc {
    self.positions = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setPositions:(CGPoint *)positions {
    if (_positions != positions) {
        if (NULL != _positions) {
            free(_positions);
        }
        
        _positions = positions;
    }
}

- (void)setSquarePosition:(IDPSquarePosition)position {
    [self setSquarePosition:position
                   animated:NO
          completionHandler:^(BOOL finished) {
              if (finished) {
                  _squarePosition = position;
              }
          }];
}

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
{
    [self setSquarePosition:IDPSquarePositionDefault
                   animated:animated
          completionHandler:^(BOOL finished) {
              if (finished) {
                  _squarePosition = position;
              }
          }];
}

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL finished))completionHandler
{
    void (^transformation)() = ^{
        CGRect frame = self.square.frame;
        
        frame.origin = self.positions[position];
        
        self.square.frame = frame;
    };
    
    if (animated) {
        [UIView animateWithDuration:IDPDuration
                              delay:IDPDealay
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:transformation
                         completion:completionHandler];
    } else {
        transformation();
        if (completionHandler) {
            completionHandler(YES);
        }
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
}

#pragma mark -
#pragma mark Public Methods

- (void)play {
    if (!self.running) {
        self.running = YES;
        
        [self animate];
    }
}

- (void)stop {
    self.running = NO;
}

#pragma mark -
#pragma mark Private Methods

- (void)animate {
    if (self.isRunning) {
        IDPSquarePosition position = (self.squarePosition + 1) % IDPSquarePositionsCount;
        
        void (^completionHandler)(BOOL finished) = ^void(BOOL finished) {
            if (!finished) {
                return;
            }
            
            _squarePosition = position;
            
            [self animate];
        };
        
        [self setSquarePosition:position
                       animated:YES
              completionHandler:completionHandler];
    }
}

- (void)setUpSquarePositions {
    CGRect viewBounds = [self bounds];
    CGRect squareBounds = [self.square bounds];
    
    int viewWidth = viewBounds.size.width;
    int viewHeight = viewBounds.size.height;
    int squareWidth = squareBounds.size.width;
    int squareHeight = squareBounds.size.height;

    CGPoint *positions = malloc(sizeof(self.positions) * IDPSquarePositionsCount);
    positions[IDPSquarePositionTopLeft] = CGPointMake(0, 0);
    positions[IDPSquarePositionTopRight] = CGPointMake(viewWidth - squareWidth, 0);
    positions[IDPSquarePositionBottomLeft] = CGPointMake(0, viewHeight - squareHeight);
    positions[IDPSquarePositionBottomRight] = CGPointMake(viewWidth - squareWidth,
                                                          viewHeight - squareHeight);
    self.positions = positions;
}

@end
