//
//  PianoKeyButton.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PianoKeyButton : UIButton

+ (instancetype)keyWithCircleColor:(UIColor *)color;
- (instancetype)initWithCircleColor:(UIColor*)color;

@end
