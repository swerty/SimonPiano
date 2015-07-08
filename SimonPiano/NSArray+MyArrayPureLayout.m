//
//  NSArray+MyArrayPureLayout.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/8/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//


#import "NSArray+MyArrayPureLayout.h"

@implementation NSArray (MyArrayPureLayout)

- (NSArray*)autoMatchDimensions:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(ALView *)otherView withMultiplier:(CGFloat)multiplier {
    NSMutableArray *constraints = [NSMutableArray new];
    for (id object in self) {
        if ([object isKindOfClass:[ALView class]]) {
            ALView *view = (ALView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [constraints addObject:[view autoMatchDimension:dimension toDimension:toDimension ofView:otherView withMultiplier:multiplier]];
        }
    }
    return constraints;
}

- (NSArray*)autoPinEdgesToSuperViewEdge:(ALEdge)edge {
    NSMutableArray *constraints = [NSMutableArray new];
    for (id object in self) {
        if ([object isKindOfClass:[ALView class]]) {
            ALView *view = (ALView *)object;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [constraints addObject:[view autoPinEdgeToSuperviewEdge:edge]];
        }
    }
    return constraints;
}

@end
