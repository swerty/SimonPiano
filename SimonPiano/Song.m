//
//  Song.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "Song.h"

@interface Song ()

@end

@implementation Song

- (instancetype)initWithTitle:(NSString *)title phrases:(NSArray *)phrases {
    self = [super init];
    if (self) {
        self.title = title;
        self.phrases = phrases;
    }
    
    return self;
}

@end
