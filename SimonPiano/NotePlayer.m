//
//  NotePlayer.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/6/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "NotePlayer.h"
#import "Note.h"

@interface NotePlayer ()

@property (assign, nonatomic) int maxNoteValue;
@property (assign, nonatomic) int minNoteValue;

@property (strong, nonatomic) NSArray *notes;

@end

@implementation NotePlayer

- (instancetype)initWithMinNoteValue:(int)minNoteValue maxNoteValue:(int)maxNoteValue{
    self = [super init];
    if (self) {
        self.minNoteValue = minNoteValue;
        self.maxNoteValue = maxNoteValue;
        
        [self setupNotes];
    }
    
    return self;
}

- (void)setupNotes {
    NSMutableArray *notes = [NSMutableArray new];
    for (int i = self.minNoteValue; i <= self.maxNoteValue; i++) {
        [notes addObject:[Note noteWithValue:i]];
    }
    self.notes = [notes copy];
}

- (void)playNoteWithValue:(int)value {
    Note *noteToPlay = self.notes[value];
    [noteToPlay play];
}

@end
