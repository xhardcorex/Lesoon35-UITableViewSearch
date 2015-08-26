//
//  NSStudent.h
//  Lesson 35 HW
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStudent : NSObject

@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* surname;
@property (strong,nonatomic) NSDate* dateOfBirth;
@property (assign,nonatomic) NSInteger month;


- (NSString*) showDateOfBirth:(NSDate*) date;

@end
