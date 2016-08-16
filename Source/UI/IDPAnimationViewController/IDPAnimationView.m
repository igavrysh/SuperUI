//
//  IDPAnimationView.m
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAnimationView.h"

#import "IDPMacro.h"

static NSTimeInterval IDPDuration   = 3.0;
static NSTimeInterval IDPDelay      = 0.0;

@interface IDPAnimationView ()
@property (nonatomic, assign) BOOL shouldStop;

- (CGPoint)squarePositionForPosition:(IDPSquarePosition)position;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL finished))completionHandler;

- (IDPSquarePosition)nextPosition;
- (CGPoint)nextSquarePosition;

- (void)animate;

@end

@implementation IDPAnimationView

#pragma mark -
#pragma mart Initializations and Deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.squarePosition = IDPSquarePositionTopRight;
}

#pragma mark -
#pragma mark Accessors

- (void)setSquarePosition:(IDPSquarePosition)position {
    [self setSquarePosition:position
                   animated:NO];
}

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
{
    [self setSquarePosition:IDPSquarePositionDefault
                   animated:animated
          completionHandler:nil];
}

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL finished))completionHandler
{
    void (^transformation)() = ^{
        CGRect frame = self.square.frame;
        
        frame.origin = [self squarePositionForPosition:position];
        
        self.square.frame = frame;
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (finished) {
            _squarePosition = position;
        }
        
        if (completionHandler) {
            completionHandler(finished);
        }
    };
    

    [UIView animateWithDuration:!animated ? 0 : IDPDuration
                          delay:IDPDelay
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:transformation
                     completion:completion];
}

- (void)setRunning:(BOOL)running {
    if (_running != running) {
        if (!running) {
            self.shouldStop = YES;
        } else {
            _running = running;
        }
        
        [self animate];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)animate {
    if (self.shouldStop) {
        return;
    }
    
    IDPWeakify(self);
    
    [self setSquarePosition:[self nextPosition]
                   animated:YES
          completionHandler:^void(BOOL finished) {
              IDPStrongify(self);
              
              if (self.shouldStop) {
                  self.shouldStop = NO;
                  _running = NO;
              }
              
              if (!finished) {
                  return;
              }
              
              if (self.running) {
                  [self animate];
              }
          }];
}

- (IDPSquarePosition)nextPosition {
    return (self.squarePosition + 1) % IDPSquarePositionsCount;
}

- (CGPoint)nextSquarePosition {
    return [self squarePositionForPosition:[self nextPosition]];
}

- (CGPoint)squarePositionForPosition:(IDPSquarePosition)position {
    CGRect viewBounds = [self bounds];
    CGRect squareBounds = [self.square bounds];
    
    int deltaWidth = CGRectGetWidth(viewBounds) - CGRectGetWidth(squareBounds);
    int deltaHeight = CGRectGetHeight(viewBounds) - CGRectGetHeight(squareBounds);
    
    CGPoint squarePosition = CGPointMake(0, 0);
    
    switch (position) {
        case IDPSquarePositionTopRight:
            squarePosition.x = deltaWidth;
            break;
            
        case IDPSquarePositionBottomRight:
            squarePosition = CGPointMake(deltaWidth, deltaHeight);
            break;
            
        case IDPSquarePositionBottomLeft:
            squarePosition.y = deltaHeight;
            break;
            
        default:
            break;
    }
    
    return squarePosition;
}

@end
