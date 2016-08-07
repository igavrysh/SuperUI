//
//  IDPAnimationView.m
//  SuperUI
//
//  Created by Ievgen on 8/6/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAnimationView.h"

static NSTimeInterval IDPDuration   = 1.5;
static NSTimeInterval IDPDelay      = 0.0;

@interface IDPAnimationView ()
@property (nonatomic, assign)                   CGPoint *positions;
@property (nonatomic, assign, getter=isRunning) BOOL    running;
@property (nonatomic, assign)                   IDPSquarePosition leadingPosition;

- (void)setUpSquarePositions;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated;

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL finished))completionHandler;

- (IDPSquarePosition)nextPosition;

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

- (IDPSquarePosition)nextPosition {
    return (self.squarePosition + 1) % IDPSquarePositionsCount;
}

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
          completionHandler:nil];
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
    self.leadingPosition = position;
    
    __weak IDPAnimationView *weakSelf = self;
    void (^transformation)() = ^{
        CGRect frame = weakSelf.square.frame;
        
        frame.origin = weakSelf.positions[position];
        
        weakSelf.square.frame = frame;
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        if (finished) {
            _squarePosition = weakSelf.leadingPosition;
            
            if (completionHandler) {
               completionHandler(YES);
            }
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:IDPDuration
                              delay:IDPDelay
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                         animations:transformation
                         completion:completion];
    } else {
        transformation();
        completion(YES);
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
        __weak IDPAnimationView *weakSelf = self;
        void (^completionHandler)(BOOL finished) = ^void(BOOL finished) {
            if (!finished) {
                return;
            }
            
            _squarePosition = weakSelf.leadingPosition;
            
            [weakSelf animate];
        };
        
        [self setSquarePosition:[self nextPosition]
                       animated:YES
              completionHandler:completionHandler
         ];
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
