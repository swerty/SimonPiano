//
//  SongFileProcessor.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <BlocksKit/BlocksKit.h>
#import "SongFileProcessor.h"
#import "NSString+TextInputVerification.h"
#import "ScoreBuilder.h"
#import "MusicalScore.h"

@interface SongFileProcessor ()

@end

@implementation SongFileProcessor

+ (void)processSongFilesWithTitles:(NSArray *)titles completion:(SongFileProcessorCompletionBlock)completion{
    __block NSError *error;
    NSArray *songTexts = [titles bk_map:^id(id obj) {
        NSString *title = (NSString *)obj;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:title ofType:nil];
        NSString *songText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        return songText;
    }];
    
    if (error) {
        completion(nil, error);
        return;
    }
    
    BOOL isValid = [songTexts bk_all:^BOOL(id obj) {
        NSString *songText = (NSString *)obj;
        return [songText songTextFormatIsValid];
    }];
    
    if (!isValid) {
        NSError *invalidInputError;
        completion(nil, invalidInputError);
    }
    
    NSMutableArray *outputSongs = [[NSMutableArray alloc] initWithCapacity:songTexts.count];
    
    for (int i = 0; i < songTexts.count; i++) {
        NSString *songText = songTexts[i];
        NSString *songTitle = titles[i];
        ScoreBuilder *scoreBuilder = [[ScoreBuilder alloc] initWithSongTitle:songTitle inputString:songText];
        MusicalScore *outputSong = [scoreBuilder buildScore];
        [outputSongs addObject:outputSong];
    }
    
    completion(outputSongs, nil);
}

//+ (void)processSongFileWithName:(NSString *)name completion:(SongFileProcessorCompletionBlock)completion {
//    
//    NSError *error;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
//    NSString *songText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
//    
//    if (error) {
//        completion(nil, error);
//        return;
//    }
//    
//    BOOL isValid = [songText songTextFormatIsValid];
//    
//    if (isValid) {
//        ScoreBuilder *scoreBuilder = [[ScoreBuilder alloc] initWithSongTitle:name inputString:songText];
//        MusicalScore *outputSong = [scoreBuilder buildScore];
//        completion(outputSong, nil);
//    } else {
//        NSError *invalidInputError;
//        completion(nil, invalidInputError);
//    }
//}

@end
