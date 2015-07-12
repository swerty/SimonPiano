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

@property (assign, nonatomic) int pickedSongIndex;
@property (assign, nonatomic) BOOL isStarting;
@property (strong, nonatomic) NSArray *songs;
@property (strong, nonatomic) AHKActionSheet *songSelectionActionSheet;
@property (strong, nonatomic) SongControlButton *startStopButton;
@property (strong, nonatomic) SongControlButton *pickSongButton;
@property (assign, nonatomic) BOOL didSetupConstraints;

@end

@implementation SongControlView

- (instancetype)initWithSongs:(NSArray *)songs{
    self = [super initWithFrame:CGRectZero]; //autolayout
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO; //so autolayout will work
        self.backgroundColor = [UIColor colorWithRed:40.0/255.0 green:105.0/255.0 blue:160.0/255.0 alpha:1.0];
        self.songs = songs;
    }
    
    return self;
}

- (void)setDelegate:(id<SongControlDelegate>)delegate {
    _delegate = delegate;
    [self reloadData];
}

- (void)reloadData {
    [self addPickSongButton];
    [self addStartStopButton];
    [self addActionSheet];
}

- (void)addPickSongButton {
    self.pickSongButton = [[SongControlButton alloc] init];
    [self.pickSongButton setTitle:@"Pick a Song" forState:UIControlStateNormal];
    
    [self.pickSongButton bk_addEventHandler:^(id sender) {
        [self.songSelectionActionSheet show];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.pickSongButton];
}

- (void)addStartStopButton {
    self.startStopButton = [[SongControlButton alloc] init];
    [self.startStopButton setTitle:@"Start/Stop" forState:UIControlStateNormal];
    [self addSubview:self.startStopButton];
    
    if (![self delegateImplementsDelegateMethods]) {
        return;
    }
    
    [self.startStopButton bk_addEventHandler:^(id sender) {
        self.isStarting = !self.isStarting;
        if (self.isStarting) {
            [self.delegate songControlDidPressStartForSongAtIndex:self.pickedSongIndex];
        } else {
            [self.delegate songControlDidRequestStop];
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)addActionSheet {
    self.songSelectionActionSheet = [[AHKActionSheet alloc] initWithTitle:@"Pick a Song!"];
    
    __weak typeof (self) weakSelf = self;
    for (int i = 0; i < [self.songs count]; i++) {
        MusicalScore *currentSong = self.songs[i];
        [self.songSelectionActionSheet addButtonWithTitle:currentSong.title type:AHKActionSheetButtonTypeDefault handler:^(AHKActionSheet *actionSheet) {
            weakSelf.pickedSongIndex = i;
        }];
    }
}

- (BOOL)delegateImplementsDelegateMethods {
    return self.delegate && [self.delegate respondsToSelector:@selector(songControlDidPressStartForSongAtIndex:)] && [self.delegate respondsToSelector:@selector(songControlDidRequestStop)];
}

- (void)addConstraints {
    
    /*self*/
    static float const heightPercentage = 0.3;
    
    [self autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.superview];
    [self autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.superview withMultiplier:heightPercentage];
    [self autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:self.superview];
    
    // Pick a Song
    static float const smallButtonHeightPercentage = 0.5;
    static float const smallButtonWidthPercentage = 0.3;
    static float const margin = 12.0;
    
    [self.pickSongButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:smallButtonHeightPercentage];
    [self.pickSongButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:smallButtonWidthPercentage];
    [self.pickSongButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.pickSongButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    
    //>start/stop
    static float const largeButtonHeightPercentage = 0.75;
    static float const largeButtonWidthPercentage = 0.4;
    
    [self.startStopButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self withMultiplier:largeButtonHeightPercentage];
    [self.startStopButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:largeButtonWidthPercentage];
    [self.startStopButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.startStopButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:margin];
}

- (void)hideSelectSongButton {
    self.pickSongButton.hidden = YES;
}

- (void)showSelectSongButton {
    self.pickSongButton.hidden = NO;
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
