//
//  SongControlButton.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/12/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "SongControlButton.h"

@implementation SongControlButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18.0];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2.0;
    }
    
    return self;
}

@end
