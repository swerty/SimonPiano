//
//  SongBuilder.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalScore;
#import <Foundation/Foundation.h>

@interface ScoreBuilder : NSError

- (instancetype)initWithSongTitle:(NSString *)title inputString:(NSString *)inputString;
- (MusicalScore *)buildScore;

@end
