//
//  NSString+Random_String.m
//  Lesoon35 UITableViewSearch
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSString+Random_String.h"

@implementation NSString (Random_String)


+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
