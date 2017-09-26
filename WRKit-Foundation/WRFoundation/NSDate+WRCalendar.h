//
//  NSDate+WRCalendar.h
//  WRKitDemo
//
//  Created by xianghui on 2017/8/18.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 日历相关日期 */
@interface NSDate (WRCalendar)
/** 年 */
@property (assign, nonatomic, readonly) NSInteger year;
/** 月 */
@property (assign, nonatomic, readonly) NSInteger month;
/** 日 */
@property (assign, nonatomic, readonly) NSInteger day;
/** 星期几 */
@property (assign, nonatomic, readonly) NSInteger weekday;
/** 本月的日期数量 */
@property (assign, nonatomic, readonly) NSInteger dayCountInMonth;
/** 本月的第一天日期 */
- (NSDate *)fisrtDayInThisMonth;
/** 本月的最后一天日期 */
- (NSDate *)lastDayInThisMonth;
/** 是否同一个月 */
- (BOOL)isSameMonth:(NSDate *)date;
/** 是否同一周 */
- (BOOL)isSameWeek:(NSDate *)date;
/** 是否同一天 */
- (BOOL)isSameDay:(NSDate *)date;

@end
