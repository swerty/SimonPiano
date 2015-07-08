//
//  Note.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "Note.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Note () {
    //cannot get the address of a property, which we need for AudioServicesCreateSystemSoundID, so soundID has to be an ivar
    SystemSoundID soundID;
}

@property (assign, nonatomic) int value;

@end

@implementation Note

+ (Note *)noteWithValue:(int)value {
    return [[Note alloc] initWithValue:value];
}

- (instancetype)initWithValue:(int)value {
    self = [super init];
    if (self) {
        self.value = value;
        [self associateWithSound];
    }
    
    return self;
}

- (void)associateWithSound {
    NSString *soundFileName = [NSString stringWithFormat:@"%d", self.value];
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:soundFileName
                                              withExtension:@"caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
}

- (void)play {
    AudioServicesPlaySystemSound(soundID);
}

@end
