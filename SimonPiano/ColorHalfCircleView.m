//
//  ColorHalfCircleView.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/2/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "ColorHalfCircleView.h"

@interface ColorHalfCircleView ()

@property (strong, nonatomic) UIColor *fillColor;

@end

@implementation ColorHalfCircleView

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor*) color{
    self = [super initWithFrame:CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius)];
    
    if (self) {
        self.layer.cornerRadius = radius;
        self.backgroundColor = color;
    }
    
    return self;
}

@end
