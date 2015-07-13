//
//  ScoreReader.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalScore;
@class MusicalPhrase;
@class NotePlayer;

#import <Foundation/Foundation.h>

@protocol ScorePlayerDelegate <NSObject>

- (void)scorePlayerDidFinishPlayingPhrase:(MusicalPhrase *)phrase;
- (void)scorePlayerDidPlayNoteWithValue:(int)value;

@end

@interface ScorePlayer : NSObject

@property (weak, nonatomic) id <ScorePlayerDelegate> delegate;
@property (assign, nonatomic) int currentPhraseIndex;

- (instancetype)initWithScore:(MusicalScore *)score BPM:(float)BPM;
- (void)playPhraseAtIndex:(int)index;
- (void)playPhraseAtIndex:(int)index afterDelay:(NSTimeInterval)delay;

@end
