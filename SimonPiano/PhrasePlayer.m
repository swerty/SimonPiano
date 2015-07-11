//
//  PhrasePlayer.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "PhrasePlayer.h"
#import "NotePlayer.h"
#import "MusicalPhrase.h"

@interface PhrasePlayer ()

@property (assign, nonatomic) int currentNote;
@property (assign, nonatomic) float secondsPerBeat;
@property (assign, nonatomic) BOOL isPhrasePlayerPlaying;
@property (strong, nonatomic) NotePlayer *notePlayer;
@property (strong, nonatomic) NSTimer *BPMTimer;

@end


@implementation PhrasePlayer

- (instancetype)initWithNotePlayer:(NotePlayer *)notePlayer{
    self = [super init];
    if (self) {
        self.notePlayer = notePlayer;
        self.currentNote = 0;
        self.BPM = 90.0; //default BPM is 90
    }
    
    return self;
}

- (void)setPhrase:(MusicalPhrase *)phrase {
    NSAssert(!self.isPhrasePlayerPlaying, @"You cannot change the phrase while the current phrase is playing.");
    
    _phrase = phrase;
    
}

- (void)setBPM:(float)BPM {
    NSAssert(!self.isPhrasePlayerPlaying, @"You cannot change the BPM while the phrase is playing.");
    
    _BPM = BPM;
    
    self.secondsPerBeat = 60.0 / BPM;
}

//pharse player waits the length of one beat before playing the phrase
- (void)playPhrase {
    [self performSelector:@selector(playPhraseAfterOneBeatDelay) withObject:self afterDelay:self.secondsPerBeat];
}

- (void)playPhraseAfterOneBeatDelay {
    NSAssert(!self.isPhrasePlayerPlaying, @"The phrase player is already playing.");
    
    self.isPhrasePlayerPlaying = YES;
    self.BPMTimer = [NSTimer scheduledTimerWithTimeInterval:self.secondsPerBeat
                                     target:self
                                   selector:@selector(playCurrentNote)
                                   userInfo:nil
                                    repeats:YES];
    [self.BPMTimer fire];
}

- (void)playCurrentNote {
    int noteValue = [self.phrase getNoteValueAtIndex:self.currentNote];
    [self.notePlayer playNoteWithValue:noteValue];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(phrasePlayerDidPlayNoteWithValue:)]) {
        [self.delegate phrasePlayerDidPlayNoteWithValue:noteValue];
    }
    
    self.currentNote++;
    
    //resetTimer and currentNote and alert delegate
    if (self.currentNote >= [self.phrase.notes count]) {
        [self.BPMTimer invalidate];
        self.BPMTimer = nil;
        self.currentNote = 0;
        self.isPhrasePlayerPlaying = NO;
        [self alertDelegateThatPhraseHasFinishedPlaying];
    }
}

- (void)alertDelegateThatPhraseHasFinishedPlaying {
    if (self.delegate && [self.delegate respondsToSelector:@selector(phrasePlayerDidFinishPlayingPhrase:)]) {
        [self.delegate phrasePlayerDidFinishPlayingPhrase:self.phrase];
    }
}

- (void)resetPlayer {
    [self.BPMTimer invalidate];
    self.BPMTimer = nil;
    self.isPhrasePlayerPlaying = NO;
    self.phrase = nil;
    self.currentNote = 0;
}

@end
