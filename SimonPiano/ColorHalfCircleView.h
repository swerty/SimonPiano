//
//  ColorHalfCircleView.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^HighlightCompletionBlock)(BOOL finished);

@interface ColorHalfCircleView : UIView

- (instancetype)initWithColor:(UIColor*) color;
- (void)highlightForDuration:(float)duration completion:(HighlightCompletionBlock)completion;

@end
