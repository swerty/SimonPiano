//
//  NSArray+MyArrayPureLayout.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/8/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PureLayout/PureLayout.h>

@interface NSArray (MyArrayPureLayout)

- (NSArray*)autoMatchDimensions:(ALDimension)dimension toDimension:(ALDimension)toDimension ofView:(ALView *)otherView withMultiplier:(CGFloat)multiplier;
- (NSArray*)autoPinEdgesToSuperViewEdge:(ALEdge)edge;
@end
