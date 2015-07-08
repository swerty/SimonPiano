//
//  Note.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

+ (Note *)noteWithValue:(int)value;
- (instancetype)initWithValue:(int)value;
- (void)play;
@end
