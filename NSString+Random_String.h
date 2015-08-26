//
//  NSString+Random_String.h
//  Lesoon35 UITableViewSearch
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random_String)
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;
+ (NSString *)randomAlphanumericString;
@end
