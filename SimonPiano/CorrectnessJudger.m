//
//  CorrecnessJudger.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "CorrectnessJudger.h"
#import "MusicalPhrase.h"

@interface CorrectnessJudger ()

@property (strong, nonatomic) MusicalPhrase *correctPhrase;

@end

@implementation CorrectnessJudger

- (instancetype)initWithCorrectPhrase:(MusicalPhrase *)phrase {
    self = [super init];
    if (self) {
        self.correctPhrase = phrase;
    }
    
    return self;
}

- (BOOL)verify {
    NSArray *correctNotes = [self.correctPhrase notes];
    NSArray *playedNotes = [self.playedPhrase notes];
    
    return [correctNotes isEqualToArray:playedNotes];
}

@end
