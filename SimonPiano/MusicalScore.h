//
//  Song.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalScore;
@class MusicalPhrase;

#import <Foundation/Foundation.h>

@interface MusicalScore : NSObject

@property (assign, nonatomic) int maxNoteValue;
@property (assign, nonatomic) int minNoteValue;
@property (assign, nonatomic, readonly) int numberOfPhrases;

@property (strong, nonatomic, readonly) NSString *title;


- (instancetype)initWithTitle:(NSString *)title phrases:(NSArray *)phrases;
- (MusicalPhrase *)getPhraseAtIndex:(int)index;

@end
