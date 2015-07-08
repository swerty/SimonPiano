//
//  Phrase.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "Phrase.h"

@implementation Phrase

- (instancetype)initWithNotes:(NSArray *)notes {
    self = [super init];
    if (self) {
        self.notes = notes;
    }
    
    return self;
}

@end
