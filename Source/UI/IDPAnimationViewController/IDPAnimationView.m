//
//  IDPAnimationView.m
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAnimationView.h"

#import "IDPMacro.h"

static NSTimeInterval IDPDuration   = 1.5;
static NSTimeInterval IDPDelay      = 0.0;

@interface IDPAnimationView ()
@property (nonatomic, assign, getter=isRunning) BOOL    running;

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
    
    self.squarePosition = IDPSquarePositionTopLeft;
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
    IDPWeakify(self);
    
    void (^transformation)() = ^{
        IDPStrongify(self);
        
        CGRect frame = self.square.frame;
        
        frame.origin = [self nextSquarePosition];
        
        self.square.frame = frame;
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        IDPStrongify(self);
        
        if (finished) {
            _squarePosition = [self nextPosition];
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

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
}

- (void)viewWillAppear:(BOOL)animated {
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
    if (!self.isRunning) {
        return;
    }
    
    IDPWeakify(self);
    
    [self setSquarePosition:[self nextPosition]
                   animated:YES
          completionHandler:^void(BOOL finished) {
              if (!finished) {
                  return;
              }
              
              IDPStrongify(self);
              
              [self animate];
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
    
    int deltaWidth = viewBounds.size.width - squareBounds.size.width;
    int deltaHeight = viewBounds.size.height - squareBounds.size.height;
    
    CGPoint squarePosition = CGPointMake(0, 0);
    
    switch (position) {
        case IDPSquarePositionTopRight:
            squarePosition.x = deltaWidth;
            break;
            
        case IDPSquarePositionBottomRight:
            squarePosition.x = deltaWidth;
            squarePosition.y = deltaHeight;
            break;
            
        case IDPSquarePositionBottomLeft:
            squarePosition.y = deltaHeight;
            
        default:
            break;
    }
    
    return squarePosition;
}

@end
