//
//  SongControlView.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/12/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SongControlDelegate <NSObject>

- (void)songControlDidRequestStop;
- (void)songControlDidStartSongAtIndex:(int)index;

@end

@interface SongControlView : UIView

@property (weak, nonatomic) id <SongControlDelegate> delegate;

@end
