//
//  ColorHalfCircleView.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "NSArray+MyArrayPureLayout.h"
#import "ColorHalfCircleView.h"

@interface ColorHalfCircleView ()

@property (assign, nonatomic) BOOL didSetupConstraints;
@property (strong, nonatomic) UIColor *circleColor;

@end

static NSString * const ColorHalfCircleViewHighlightAnimationKey = @"ColorHalfCircleViewHighlightAnimationKey";

@implementation ColorHalfCircleView

- (instancetype)initWithColor:(UIColor*) color{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentMode = UIViewContentModeRedraw;
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = color;
    }
    
    return self;
}

- (void)layoutSubviews {
    [self addShapeLayer];
}

- (void)addShapeLayer {
    CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = CGRectGetWidth(self.bounds) / 2.0;
    CGFloat lineWidth = 0.0;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                              radius:radius
                                                          startAngle:M_PI
                                                            endAngle:0
                                                           clockwise:YES];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.path = circlePath.CGPath;
    circleLayer.strokeColor = [self.circleColor CGColor];
    circleLayer.fillColor = [self.circleColor CGColor];
    circleLayer.lineWidth = lineWidth;
    circleLayer.strokeStart = 0.0;
    circleLayer.strokeEnd = 1.0;
    
    [self.layer addSublayer:circleLayer];
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
}

- (CGSize)intrinsicContentSize {
    
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

- (void)highlightForDuration:(float)duration completion:(HighlightCompletionBlock)completion {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.autoreverses = YES;
//    animation.repeatCount = 1; // Play it just once, and then reverse it
    animation.toValue = @0.1;
    [self.layer addAnimation:animation forKey:ColorHalfCircleViewHighlightAnimationKey];
}

@end
