//
//  Phrase.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class Note;
#import <Foundation/Foundation.h>

@interface MusicalPhrase : NSObject

@property (assign, nonatomic, readonly) int length;
@property (strong, nonatomic, readonly) NSArray *notes;
- (instancetype)initWithNoteValues:(NSArray*)noteValues;
- (int)getNoteValueAtIndex:(int)index;

@end
