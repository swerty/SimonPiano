//
//  SongFileProcessor.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "SongFileProcessor.h"
#import "NSString+TextInputVerification.h"
#import "SongBuilder.h"
#import "Song.h"

@interface SongFileProcessor ()

@end

@implementation SongFileProcessor

- (void)processSongFileWithName:(NSString *)name completion:(SongFileProcessorCompletionBlock)completion {
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    NSString *songText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        completion(nil, error);
    }
    
    BOOL isValid = [songText formatIsValidForSongText:songText];
    
    if (isValid) {
        Song *outputSong = [SongBuilder buildSongWithTitle:name string:songText];
        completion(outputSong, nil);
    } else {
        NSError *invalidInputError;
        completion(nil, invalidInputError);
    }
}

@end
