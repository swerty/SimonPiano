//
//  SongFileProcessor.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "SongFileProcessor.h"
#import "NSString+TextInputVerification.h"
#import "ScoreBuilder.h"
#import "MusicalScore.h"

@interface SongFileProcessor ()

@end

@implementation SongFileProcessor

+ (void)processSongFileWithName:(NSString *)name completion:(SongFileProcessorCompletionBlock)completion {
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSString *songText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        completion(nil, error);
    }
    
    BOOL isValid = [songText formatIsValidForSongText:songText];
    
    if (isValid) {
        ScoreBuilder *scoreBuilder = [[ScoreBuilder alloc] initWithSongTitle:name inputString:songText];
        MusicalScore *outputSong = [scoreBuilder buildScore];
        completion(outputSong, nil);
    } else {
        NSError *invalidInputError;
        completion(nil, invalidInputError);
    }
}

@end
