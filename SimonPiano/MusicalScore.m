//
//  Song.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "MusicalScore.h"
#import "MusicalPhrase.h"

@interface MusicalScore ()

@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic) NSArray *phrases;
@property (assign, nonatomic, readwrite) int numberOfPhrases;

@end

@implementation MusicalScore

- (instancetype)initWithTitle:(NSString *)title phrases:(NSArray *)phrases {
    self = [super init];
    if (self) {
        self.title = title;
        self.phrases = phrases;
        self.numberOfPhrases = (int)[phrases count];
    }
    
    return self;
}

- (MusicalPhrase *)getPhraseAtIndex:(int)index {
    
    return self.phrases[index];
}

@end
