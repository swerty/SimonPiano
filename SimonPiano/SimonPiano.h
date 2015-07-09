//
//  SimonPiano.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SimonPiano;

@protocol SimonPianoDataSource <NSObject>
- (UIColor *)colorForKeyHalfCircleAtIndex:(NSInteger)index;
- (int)numberOfKeysInPiano;
@end

@protocol SimonPianoDelegate <NSObject>
- (void)simonPiano:(SimonPiano *)simonPiano didPressKeyAtIndex:(int)index;
@end

@interface SimonPiano : UIView
@property (weak, nonatomic) id <SimonPianoDataSource> dataSource;
@property (weak, nonatomic) id <SimonPianoDelegate> delegate;
@property (assign, nonatomic) BOOL allowsChords;

- (void)reloadData;


@end
