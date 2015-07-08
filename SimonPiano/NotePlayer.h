//
//  NotePlayer.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/6/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotePlayer : NSObject

- (instancetype)initWithNumberOfNotes:(int)numberOfNotes;
- (void)playNoteWithValue:(int)value;

@end
