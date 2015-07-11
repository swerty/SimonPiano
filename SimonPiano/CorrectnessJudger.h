//
//  CorrecnessJudger.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/9/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalPhrase;
#import <Foundation/Foundation.h>

@interface CorrectnessJudger : NSObject

@property (strong, nonatomic) MusicalPhrase *playedPhrase;
- (instancetype)initWithCorrectPhrase:(MusicalPhrase *)phrase;
- (BOOL)verify;

@end
