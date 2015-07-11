//
//  PhraseGenerator.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/10/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalPhrase;
#import <Foundation/Foundation.h>

@protocol PhraseGeneratorDelegate <NSObject>

- (void)phraseGeneratorDidGeneratePhrase:(MusicalPhrase *)phrase;

@end

@interface PhraseGenerator : NSObject

@property (weak, nonatomic) id <PhraseGeneratorDelegate> delegate;

- (instancetype)initWithPhraseLength:(int)phraseLength;
- (void)addNoteWithValue:(int)noteValue;
@end
