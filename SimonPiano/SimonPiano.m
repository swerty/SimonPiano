//
//  SimonPiano.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "NSArray+MyArrayPureLayout.h"
#import "SimonPiano.h"
#import "PianoKeyButton.h"

@interface SimonPiano ()

@property (assign, nonatomic) int numberOfKeys;
@property (strong, nonatomic) NSMutableArray *keys;
@property (assign, nonatomic) BOOL didSetupConstraints;

@end

@implementation SimonPiano

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO; //so autolayout will work
        self.keys = [NSMutableArray new];
    }
    
    return self;
}

- (void)reloadData {
    if ([self dataSourceImplementsDataSourceProtocol]) {
        self.keys = [NSMutableArray new];
        self.numberOfKeys = [self.dataSource numberOfKeysInPiano];
        [self addPianoKeys];
        [self setNeedsUpdateConstraints];
//        [self setNeedsLayout];
    }
}

- (void)addPianoKeys {
    for (int i = 0; i < self.numberOfKeys; i++) {
        UIColor *keyColor = [self.dataSource colorForKeyHalfCircleAtIndex:i];
        PianoKeyButton *key = [PianoKeyButton keyWithCircleColor:keyColor];
        [self addSubview:key];
        [self.keys addObject:key];
    }
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [self addConstraintsToPiano];
        [self addConstraintsToKeys];
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)addConstraintsToPiano {
    //the piano is the same width and half the height its superview
    [self autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.superview];
    [self autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:0.5];
    
    //the piano is anchored to the bottom of its superview and centered horizontally
    [self autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.superview];
    [self autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self.superview];
}

- (void)addConstraintsToKeys {
    [self.keys autoMatchDimensions:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:0.5];
    [self.keys autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeBottom withFixedSpacing:0.0];
}

- (BOOL)dataSourceImplementsDataSourceProtocol {
    return self.dataSource &&
    [self.dataSource respondsToSelector:@selector(numberOfKeysInPiano)] &&
    [self.dataSource respondsToSelector:@selector(colorForKeyHalfCircleAtIndex:)];
}

@end
