//
//  NSStudent.m
//  Lesson 35 HW
//
//  Created by Nik on 25.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSStudent.h"
@interface NSStudent ()


@end
@implementation NSStudent
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.name = [self createName];
        self.surname = [self createSurname];
        self.dateOfBirth = [self crateDateOfBirth];
        self.month =  [self getMonthFromDate:self.dateOfBirth];
    }
    return self;
}

- (NSString*) createName{
    
    NSArray* namesArray = [[NSArray alloc]initWithObjects:
                           @"Александр",
                           @"Иван",
                           @"Сергей",
                           @"Роберт",
                           @"Никита",
                           @"Вова",
                           @"Вадим",
                           @"Влад",
                           @"Григорий",
                           @"Назар",
                           nil];
    
    return [namesArray objectAtIndex:arc4random()%10];
}
- (NSString*) createSurname{
    
    NSArray* surnamesArray = [[NSArray alloc]initWithObjects:
                              @"Коноплянка",
                              @"Ярмоленко",
                              @"Коваленко",
                              @"Шевченко",
                              @"Левандовский",
                              @"Мюллер",
                              @"Иванович",
                              @"Гройсман",
                              @"Порошенко",
                              @"Суарез",
                              nil];
    
    return [surnamesArray objectAtIndex:arc4random()%10];
}


- (NSDate*) crateDateOfBirth {
    
    NSInteger rand = arc4random()%2000000000;

    NSString *dateStr = @"2014-10-15";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    date =  [date dateByAddingTimeInterval:-rand];
  
   
    
    return date;
    
}
- (NSString*) showDateOfBirth:(NSDate*) date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormat stringFromDate:date];
   
    
    
    return string;

}

- (NSInteger) getMonthFromDate:(NSDate*) date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    NSString *string = [dateFormat stringFromDate:date];
    
    NSInteger month = string.integerValue;
   // NSLog(@"%d",month);
    
    return month;
    
}
@end
