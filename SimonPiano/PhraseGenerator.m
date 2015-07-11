//
//  PhraseGenerator.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/10/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "PhraseGenerator.h"
#import "MusicalPhrase.h"

@interface PhraseGenerator ()

@property (assign, nonatomic) int phraseLength;
@property (strong, nonatomic) NSMutableArray *valuesOfNotesPlayed;

@end

@implementation PhraseGenerator

- (instancetype)initWithPhraseLength:(int)phraseLength {
    self = [super init];
    if (self) {
        self.valuesOfNotesPlayed = [[NSMutableArray alloc] init];
        self.phraseLength = phraseLength;
    }
    
    return self;
}

- (void)addNoteWithValue:(int)noteValue {
    [self.valuesOfNotesPlayed addObject:[NSNumber numberWithInt:noteValue]];
    if ([self.valuesOfNotesPlayed count] >= self.phraseLength) {
        [self alertDelegatePhraseIsDoneGenerating];
    }
}

- (void)alertDelegatePhraseIsDoneGenerating {
    if (self.delegate && [self.delegate respondsToSelector:@selector(phraseGeneratorDidGeneratePhrase:)]) {
        MusicalPhrase *generatedPhrase = [[MusicalPhrase alloc] initWithNoteValues:self.valuesOfNotesPlayed];
        [self.delegate phraseGeneratorDidGeneratePhrase:generatedPhrase];
    }
}

@end
