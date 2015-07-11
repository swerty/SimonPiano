//
//  ScoreReader.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "ScorePlayer.h"
#import "PhrasePlayer.h"
#import "NotePlayer.h"
#import "MusicalScore.h"

@interface ScorePlayer () <PhrasePlayerDelegate>

@property (assign, nonatomic) BOOL isScorePlayerPlaying;
@property (assign, nonatomic) float BPM;
@property (assign, nonatomic) float secondsPerBeat;

@property (strong, nonatomic) MusicalScore *score;
@property (strong, nonatomic) NotePlayer *notePlayer;
@property (strong, nonatomic) PhrasePlayer *phrasePlayer;

@end

@implementation ScorePlayer

- (instancetype)initWithScore:(MusicalScore *)score BPM:(float)BPM {
    self = [super init];
    if (self) {
        self.score = score;
        self.notePlayer = [[NotePlayer alloc] initWithMinNoteValue:score.minNoteValue maxNoteValue:score.maxNoteValue];
        self.phrasePlayer = [[PhrasePlayer alloc] initWithNotePlayer:self.notePlayer];
        self.phrasePlayer.delegate = self;
        self.BPM = BPM;
    }
    
    return self;
}

- (void)playPhraseAtIndex:(int)index {
    MusicalPhrase *phrase = [self.score getPhraseAtIndex:index];
    self.phrasePlayer.phrase = phrase;
    [self.phrasePlayer playPhrase];
}

- (void)phrasePlayerDidFinishPlayingPhrase:(MusicalPhrase *)phrase {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scorePlayerDidFinishPlayingPhrase:)]) {
        [self.delegate scorePlayerDidFinishPlayingPhrase:phrase];
    }
}

- (void)phrasePlayerDidPlayNoteWithValue:(int)value {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scorePlayerDidPlayNoteWithValue:)]) {
        [self.delegate scorePlayerDidPlayNoteWithValue:value];
    }
}

@end
