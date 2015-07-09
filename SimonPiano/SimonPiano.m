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
        self.allowsChords = NO;
    }
    
    return self;
}

- (void)setAllowsChords:(BOOL)allowsChords {
    _allowsChords = allowsChords;
    for (PianoKeyButton *key in self.keys) {
        key.exclusiveTouch = !allowsChords;
    }
}

- (void)reloadData {
    if ([self dataSourceImplementsDataSourceProtocol]) {
        self.keys = [NSMutableArray new];
        self.numberOfKeys = [self.dataSource numberOfKeysInPiano];
        [self addPianoKeys];
        [self setNeedsUpdateConstraints];
        [self setNeedsLayout];
    }
}

- (void)addPianoKeys {
    for (int i = 0; i < self.numberOfKeys; i++) {
        int displayedNoteValue = i;
        UIColor *keyColor = [self.dataSource colorForKeyHalfCircleAtIndex:i];
        PianoKeyButton *key = [PianoKeyButton keyWithCircleColor:keyColor noteValue: displayedNoteValue];
        key.exclusiveTouch = !self.allowsChords;
        [key addTarget:self action:@selector(keyWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:key];
        [self.keys addObject:key];
    }
}

- (void)keyWasPressed:(id)sender {
    PianoKeyButton *key = (PianoKeyButton *)sender;
    int arrayIndex = key.noteValue - 1;
    [self.delegate simonPiano:self didPressKeyAtIndex:arrayIndex];
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
    [self autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self.superview];
}

- (void)addConstraintsToKeys {
    //the keys are the same height as the piano (self)
    [self.keys autoMatchDimensions:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:1.0];
    
    //the keys are all the same width, with no spacing in between
    [self.keys autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0];
    
    
    //the keys are attached to the bottom of the piano
    [self.keys autoPinEdgesToSuperViewEdge:ALEdgeBottom];
}

- (BOOL)dataSourceImplementsDataSourceProtocol {
    return self.dataSource &&
    [self.dataSource respondsToSelector:@selector(numberOfKeysInPiano)] &&
    [self.dataSource respondsToSelector:@selector(colorForKeyHalfCircleAtIndex:)];
}

@end
