//
//  SimonPianoViewController.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/3/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//


@class Song;
#import <UIKit/UIKit.h>

@interface SimonPianoViewController : UIViewController
- (instancetype)initWithSong:(Song *)song;
@end
