//
//  NotePlayer.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/6/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotePlayer : NSObject

- (instancetype)initWithMinNoteValue:(int)minNoteValue maxNoteValue:(int)maxNoteValue;
- (void)playNoteWithValue:(int)value;

@end
