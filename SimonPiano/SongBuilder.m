//
//  SongBuilder.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <BlocksKit/BlocksKit.h>

#import "SongBuilder.h"
#import "Phrase.h"
#import "Note.h"

static NSString * const SongBuilderPhraseDelimiter = @"\n";
static NSString * const SongBuilderNoteDelimiter = @"-";

@implementation SongBuilder

+ (Song *)buildSongWithTitle:(NSString *)title string:(NSString *)string {
    NSArray *phrases = [self phrasesFromString:string];
    return [[Song alloc]initWithTitle:title phrases:phrases];
}

+ (NSArray *)phrasesFromString:(NSString *)string {
    NSArray *lines = [string componentsSeparatedByString:SongBuilderPhraseDelimiter];
    NSArray *phrases = [lines bk_map:^Phrase*(NSString *string) {
        return [self phraseFromString:string];
    }];
    
    return phrases;
}

+ (Phrase *)phraseFromString:(NSString *)phraseString {
    NSArray *noteValues = [phraseString componentsSeparatedByString:SongBuilderNoteDelimiter];
    
    return [[Phrase alloc] initWithNotes:[self notesWithNoteValues:noteValues]];
}

+ (NSArray *)notesWithNoteValues:(NSArray *)noteValues {
    NSArray *notes = [noteValues bk_map:^id(id noteValue) {
        return [[Note alloc] initWithValue:(int)noteValue];
    }];
    
    return notes;
}

@end
