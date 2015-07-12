//
//  SongControlView.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/12/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <BlocksKit+UIKit.h>
#import <PureLayout/PureLayout.h>
#import <AHKActionSheet/AHKActionSheet.h>
#import "SongControlView.h"
#import "SongControlButton.h"
#import "MusicalScore.h"

@interface SongControlView ()

@property (strong, nonatomic) UIButton *maryHadALittleLambButton;
@property (strong, nonatomic) UIButton *ABCsButton;
@property (strong, nonatomic) UIButton *startStopButton;
//
@property (strong, nonatomic) NSArray *songs;
@property (strong, nonatomic) AHKActionSheet *songSelectionActionSheet;
@property (assign, nonatomic) BOOL didSetupConstraints;

@end

@implementation SongControlView

- (instancetype)initWithSongs:(NSArray *)songs{
    self = [super initWithFrame:CGRectZero]; //autolayout
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO; //so autolayout will work
        self.backgroundColor = [UIColor colorWithRed:40.0/255.0 green:105.0/255.0 blue:160.0/255.0 alpha:1.0];
        
        self.maryHadALittleLambButton = [[SongControlButton alloc] init];
        self.ABCsButton = [[SongControlButton alloc] init];
        self.startStopButton = [[SongControlButton alloc] init];
        
        [self.maryHadALittleLambButton setTitle:@"Mary Had A Little Lamb" forState:UIControlStateNormal];
        [self.ABCsButton setTitle:@"ABCs" forState:UIControlStateNormal];
        [self.startStopButton setTitle:@"Start/Stop" forState:UIControlStateNormal];
        
        [self addSubview:self.maryHadALittleLambButton];
        [self addSubview:self.ABCsButton];
        [self addSubview:self.startStopButton];
        
        [self addEventHandlers];
    }
    
    return self;
}

//will need to refactor design to handle more songs (e.g. use uipickerview instead of buttons, but for now 2 buttons works)
- (void)addEventHandlers {
    if ([self delegateImplementsDelegateMethods]) {
        
    }
}

- (BOOL)delegateImplementsDelegateMethods {
    return self.delegate && [self.delegate respondsToSelector:@selector(songControlDidStartSongAtIndex:)] && [self.delegate respondsToSelector:@selector(songControlDidRequestStop)];
}

- (void)addConstraints {
    
    /*self*/
    static float const heightPercentage = 0.3;
    
    [self autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.superview];
    [self autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:heightPercentage];
    [self autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self.superview];
    
    /*small buttons*/
    static float const smallButtonHeightPercentage = 0.5;
    static float const smallButtonWidthPercentage = 0.2;
    static float const margin = 12.0;
    
    //>mary had a little lamb
    [self.maryHadALittleLambButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:smallButtonHeightPercentage];
    [self.maryHadALittleLambButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:smallButtonWidthPercentage];
    [self.maryHadALittleLambButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.maryHadALittleLambButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    
    //>ABCs
    [self.ABCsButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:smallButtonHeightPercentage];
    [self.ABCsButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:smallButtonWidthPercentage];
    [self.ABCsButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.ABCsButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.maryHadALittleLambButton withOffset:margin];
    
    /*large buttons*/
    
    //>start/stop
    static float const largeButtonHeightPercentage = 0.75;
    static float const largeButtonWidthPercentage = 0.4;
    
    [self.startStopButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:largeButtonHeightPercentage];
    [self.startStopButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:largeButtonWidthPercentage];
    [self.startStopButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.startStopButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:margin];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [self addConstraints];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
