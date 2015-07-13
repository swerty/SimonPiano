//
//  ScorePlayer+WinJingle.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/13/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "ScorePlayer+WinJingle.h"
#import "MusicalPhrase.h"
#import "MusicalScore.h"

@implementation ScorePlayer (WinJingle)

+ (ScorePlayer *)playerForWinJingle {
    NSArray *winPhraseValues = @[@5, @4, @3, @2, @1, @2, @3, @4, @5, @6, @5, @4, @3];
    MusicalPhrase *winPhrase = [[MusicalPhrase alloc] initWithNoteValues:winPhraseValues];
    MusicalScore *score = [[MusicalScore alloc] initWithTitle:nil phrases:@[winPhrase]];
    score.minNoteValue = 1;
    score.maxNoteValue = 6;
    ScorePlayer *player = [[ScorePlayer alloc] initWithScore:score BPM:580.0];
    
    return player;
}

@end
