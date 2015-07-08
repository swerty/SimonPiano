//
//  Song.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

@class Song;

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *phrases;

- (instancetype)initWithTitle:(NSString *)title phrases:(NSArray *)phrases;

@end
