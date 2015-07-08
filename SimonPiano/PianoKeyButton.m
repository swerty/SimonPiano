//
//  PianoKeyButton.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "PianoKeyButton.h"
#import "ColorHalfCircleView.h"

@interface PianoKeyButton ()

@property (strong, nonatomic) ColorHalfCircleView *halfCircleView;

@end

@implementation PianoKeyButton

+ (instancetype)keyWithCircleColor:(UIColor *)color {
    return [[PianoKeyButton alloc] initWithCircleColor:color];
}

- (instancetype)initWithCircleColor:(UIColor*)color {
    //we are using autolayout so frame is ignored
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addKeyBorder];
        [self addHalfCircleViewWithColor:color];
    }
    
    return self;
}

- (void)addKeyBorder {
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)addHalfCircleViewWithColor:(UIColor *)color {
    //circle is centered and half obscured by piano key
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));
    CGFloat circleRadius = CGRectGetWidth(self.bounds) / 2.f;
    
    self.halfCircleView = [[ColorHalfCircleView alloc] initWithCenter:circleCenter radius:circleRadius color:color];
    [self addSubview:self.halfCircleView];
}

@end
