//
//  SongBuilder.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface SongBuilder : NSError

+ (Song *)buildSongWithTitle:(NSString *)title string:(NSString *)string;

@end
