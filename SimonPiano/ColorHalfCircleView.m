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

@implementation ColorHalfCircleView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 0.0;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds) / 2.0, 0, M_PI, 1);
    CGContextFillPath(context);
    
}

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

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
}

- (CGSize)intrinsicContentSize {
    
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

@end
