//
//  PianoKeyButton.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "NSArray+MyArrayPureLayout.h"

#import "PianoKeyButton.h"
#import "ColorHalfCircleView.h"

@interface PianoKeyButton ()

@property (strong, nonatomic) ColorHalfCircleView *halfCircleView;
@property (assign, nonatomic) BOOL didSetupConstraints;
@property (strong, nonatomic) UIColor *circleColor;


@end

@implementation PianoKeyButton

+ (instancetype)keyWithCircleColor:(UIColor *)color noteValue:(int)noteValue{
    return [[PianoKeyButton alloc] initWithCircleColor:color noteValue:noteValue];
}

- (instancetype)initWithCircleColor:(UIColor*)color noteValue:(int)noteValue{
    //we are using autolayout so frame is ignored
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.circleColor = color;
        self.noteValue = noteValue;
        [self addKeyBorder];
    }
    
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self addHalfCircleView];
        [self addNumberLabel];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)addKeyBorder {
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)addHalfCircleView {
    self.halfCircleView = [[ColorHalfCircleView alloc] initWithColor:self.circleColor];
    
    [self addSubview:self.halfCircleView];
    [self.halfCircleView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self];
    [self.halfCircleView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self];
    [self.halfCircleView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.halfCircleView autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeTop ofView:self];
}

- (void)addNumberLabel {
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.text = [NSString stringWithFormat:@"%d", self.noteValue];
    numberLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18.0];
    
    [self addSubview:numberLabel];
    [numberLabel autoCenterInSuperview];
}

@end
