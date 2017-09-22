//
//  NSDate+WRCalendar.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/18.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import "NSDate+WRCalendar.h"

@implementation NSDate (WRCalendar)

- (NSInteger)year {
    return self.dateComponents.year;
}
- (NSInteger)month {
    return self.dateComponents.month;
}
- (NSInteger)day {
    return self.dateComponents.day;
}
- (NSInteger)weekday {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:self];
}
- (NSInteger)dayCountInMonth {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}
- (NSDate *)fisrtDayInThisMonth {
    NSInteger currentDay = self.day;
    NSInteger timeInterval = (currentDay - 1) * 24 * 3600;
    NSDate *date = [NSDate dateWithTimeInterval:-timeInterval sinceDate:self];
    return date;
}
- (NSDate *)lastDayInThisMonth {
    NSInteger monthDays = self.dayCountInMonth;
    NSInteger currentDay = self.day;
    NSInteger timeInterval = (monthDays - currentDay) * 24 * 3600;
    NSDate *date = [NSDate dateWithTimeInterval:timeInterval sinceDate:self];
    return date;
}
- (BOOL)isSameMonth:(NSDate *)date {
    return  self.year == date.year && self.month == date.month;

}
- (BOOL)isSameWeek:(NSDate *)date {
    return self.year == date.year && self.weekday == date.weekday;
}
- (BOOL)isSameDay:(NSDate *)date {
    return self.year == date.year && self.month == date.month && self.day == date.day;
}

#pragma mark - private
- (NSDateComponents *)dateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return dateComponent;
}

@end
