//
//  NSString+TextInputVerification.h
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextInputVerification)

- (BOOL)formatIsValidForSongText:(NSString *)songText;

@end
