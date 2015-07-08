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

@property (assign, nonatomic) int numberOfNotes;
@property (strong, nonatomic) NSArray *notes;

@end

@implementation NotePlayer

- (instancetype)initWithNumberOfNotes:(int)numberOfNotes{
    self = [super init];
    if (self) {
        [self setupNotes];
    }
    
    return self;
}

- (void)setupNotes {
    NSMutableArray *notes;
    for (int i = 0; i < self.numberOfNotes; i++) {
        [notes addObject:[Note noteWithValue:i]];
    }
    self.notes = notes;
}

- (void)playNoteWithValue:(int)value {
    Note *noteToPlay = self.notes[value];
    [noteToPlay play];
}

@end
