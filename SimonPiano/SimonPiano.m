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
    //the piano is anchored to the bottom of its superview and centered horizontally
    [self autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self autoCenterInSuperview];
    
    //the piano is the same width and half the height its superview
    [self autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.superview];
    [self autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:0.5];
}

- (void)addConstraintsToKeys {
    [self.keys autoMatchDimensions:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:0.5];
    [self.keys autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeBottom withFixedSpacing:0.0];
}

- (void)addConstraintsForPiano {
    // Pin the bottom of subview to the bottom of containerView.
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

- (void)addConstraintsForKey:(PianoKeyButton *)key atIndex:(int)index {
    NSString *keyName = [NSString stringWithFormat:@"key%d", index];
    NSDictionary *viewsDictionary = @{keyName : key};
    
    //Height and vertical position constraint
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", keyName]
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:viewsDictionary]];
    
    // Width constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:key
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0/(float)self.numberOfKeys
                                                      constant:0]];
    
    int indexOfPreviousKey = index - 1;
    // Horizontal position constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:key
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.keys[indexOfPreviousKey]
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0]];
    
}

- (void)addConstraintsForKeys {
    
}

- (BOOL)dataSourceImplementsDataSourceProtocol {
    return self.dataSource &&
    [self.dataSource respondsToSelector:@selector(numberOfKeysInPiano)] &&
    [self.dataSource respondsToSelector:@selector(colorForKeyHalfCircleAtIndex:)];
}

@end
