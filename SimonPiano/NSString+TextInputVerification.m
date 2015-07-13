//
//  NSString+TextInputVerification.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/5/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "NSString+TextInputVerification.h"

@implementation NSString (TextInputVerification)

- (BOOL)songTextFormatIsValid{
    NSString *regexString = @"^(\\d[-\\n])*\\d$"; // double backslash necessary to escape backslash
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    BOOL valid = [predicate evaluateWithObject:self];
    
    return valid;
}

@end