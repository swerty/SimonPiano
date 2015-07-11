//
//  SongTextProcessor.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class MusicalScore;

#import <Foundation/Foundation.h>

typedef void (^SongFileProcessorCompletionBlock)(MusicalScore *song, NSError *error);

@interface SongFileProcessor : NSObject

+ (void)processSongFileWithName:(NSString *)name completion:(SongFileProcessorCompletionBlock)completion;

@end
