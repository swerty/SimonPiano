//
//  PhrasePlayer.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalPhrase;
@class NotePlayer;

#import <Foundation/Foundation.h>

@protocol PhrasePlayerDelegate <NSObject>

- (void)phrasePlayerDidFinishPlayingPhrase:(MusicalPhrase *)phrase;
- (void)phrasePlayerDidPlayNoteWithValue:(int)value;

@end

@interface PhrasePlayer : NSObject

@property (weak, nonatomic) id <PhrasePlayerDelegate> delegate;
@property (strong, nonatomic) MusicalPhrase *phrase;
@property (assign, nonatomic) float BPM;

- (instancetype)initWithNotePlayer:(NotePlayer *)notePlayer;
- (void)playPhrase;
- (void)playPhraseAfterDelay:(NSTimeInterval)delay;

@end
