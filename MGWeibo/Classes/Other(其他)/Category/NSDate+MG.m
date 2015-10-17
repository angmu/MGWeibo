//
//  NSDate+MG.m
//  MGWeibo
//
//  Created by 穆良 on 15/10/9.
//  Copyright © 2015年 穆良. All rights reserved.
//

#import "NSDate+MG.h"

@implementation NSDate (MG)
/**
 *  是否是今天
 */
- (BOOL)isToday
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //1.获得当前时间的年月日
    NSDateComponents *newCmps = [calender components:unit fromDate:[NSDate date]];
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calender components:unit fromDate:self];
    
    return
    (newCmps.year == selfCmps.year) &&
    (newCmps.month == selfCmps.month) &&
    (newCmps.day == selfCmps.day);
}

/**
 *  是否是昨天
 */
- (BOOL)isYesterday
{
    //2014-05-01 18:45:56
    //2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    //2014-04-30 19:23:49
    //2014-04-30 19:23:49
    NSDate *selfDate = [self dateWithYMD];
    
    //只关注天数的差别 获得nowDate和selfDate的差距
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calender components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];

    return cmps.day == 1;
}

/**
 *  是否是今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //1.获得当前时间的年月日
    NSDateComponents *newCmps = [calender components:unit fromDate:[NSDate date]];
    //2.获得self的年月日
    NSDateComponents *selfCmps = [calender components:unit fromDate:self];
    
    return (newCmps.year == selfCmps.year);
}

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow
{
    //2014-09-10 18:40:30
    //2014-09-10 19:50:50
    //1h 10m 20s
    NSCalendar *calender = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    return [calender components:unit fromDate:self toDate:[NSDate date] options:0];
}

/**
 *  返回只包含年月日的时间
 */
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    return [fmt dateFromString:dateStr];
}
@end
