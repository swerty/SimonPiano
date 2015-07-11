//
//  Phrase.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "MusicalPhrase.h"

@interface MusicalPhrase ()

@property (strong, nonatomic, readwrite) NSArray *notes;
@property (assign, nonatomic, readwrite) int length;

@end

@implementation MusicalPhrase

- (instancetype)initWithNoteValues:(NSArray *)noteValues {
    self = [super init];
    if (self) {
        self.notes = [NSArray arrayWithArray:noteValues];
        self.length = (int)[noteValues count];
    }
    
    return self;
}

- (int)getNoteValueAtIndex:(int)index {
    NSNumber *value = self.notes[index];
    return [value intValue];
}

@end
