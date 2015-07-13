//
//  SongBuilder.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <BlocksKit/BlocksKit.h>

#import "ScoreBuilder.h"
#import "MusicalScore.h"
#import "MusicalPhrase.h"
#import "Note.h"

static NSString * const SongBuilderPhraseDelimiter = @"\n";
static NSString * const SongBuilderNoteDelimiter = @"-";

@interface ScoreBuilder ()

@property (strong, nonatomic) NSString *songTitle;
@property (strong, nonatomic) NSString *inputString;

@property (assign, nonatomic) int maxNoteValue;
@property (assign, nonatomic) int minNoteValue;

@end

@implementation ScoreBuilder

- (instancetype)initWithSongTitle:(NSString *)title inputString:(NSString *)inputString {
    self = [super init];
    if (self) {
        self.minNoteValue = INT_MAX;
        self.maxNoteValue = INT_MIN;
        self.songTitle = title;
        self.inputString = inputString;
    }
    
    return self;
}

- (MusicalScore *)buildScore {
    NSArray *phrases = [self phrasesFromString:self.inputString];
    
    MusicalScore *score = [[MusicalScore alloc]initWithTitle:self.songTitle phrases:phrases];
    score.maxNoteValue = self.maxNoteValue;
    score.minNoteValue = self.minNoteValue;
    
    return score;
}

- (NSArray *)phrasesFromString:(NSString *)string {
    NSArray *lines = [string componentsSeparatedByString:SongBuilderPhraseDelimiter];
    NSArray *phrases = [lines bk_map:^MusicalPhrase*(NSString *string) {
        return [self phraseFromString:string];
    }];
    
    return phrases;
}

- (MusicalPhrase *)phraseFromString:(NSString *)phraseString {
    NSArray *noteValues = [phraseString componentsSeparatedByString:SongBuilderNoteDelimiter];
    
    noteValues = [noteValues bk_map:^id(id obj) {
        NSString *noteString = (NSString *)obj;
        return [NSNumber numberWithInt:[noteString intValue]];
    }];
    
    [noteValues bk_each:^(id obj) {
        NSNumber *num = (NSNumber *)obj;
        int currentValue = [num intValue];
        self.maxNoteValue = (self.maxNoteValue > currentValue) ? self.maxNoteValue : currentValue;
        self.minNoteValue = (self.minNoteValue < currentValue) ? self.minNoteValue : currentValue;
    }];
    
    return [[MusicalPhrase alloc] initWithNoteValues:noteValues];
}

@end
