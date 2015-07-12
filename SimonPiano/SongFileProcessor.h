//
//  SongTextProcessor.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalScore;

#import <Foundation/Foundation.h>

typedef void (^SongFileProcessorCompletionBlock)(NSArray *outputSongs, NSError *error);

@interface SongFileProcessor : NSObject

+ (void)processSongFilesWithTitles:(NSArray *)titles completion:(SongFileProcessorCompletionBlock)completion;
//+ (void)processSongFileWithName:(NSString *)name completion:(SongFileProcessorCompletionBlock)completion;

@end
