//
//  NSDate+QSP.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/3.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "NSDate+QSP.h"

@implementation NSDate (QSP)

- (NSDateComponents *)takenDateComponents:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    return [calendar components:unit fromDate:date];
}
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    //获得当前时间年月日
    NSDateComponents *currentComponents = [self takenDateComponents:[NSDate date]];
    
    //获得自己的年月日
    NSDateComponents *selfComponents = [self takenDateComponents:self];
    
    return currentComponents.year == selfComponents.year && currentComponents.month == selfComponents.month && currentComponents.day == selfComponents.day;
}
/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    /*  方案一根据日历的情况进行判断
    //获得当前时间年月日
    NSDateComponents *currentComponents = [self takenDateComponents:[NSDate date]];
    
    //获得自己的年月日
    NSDateComponents *selfComponents = [self takenDateComponents:self];
    
    if (currentComponents.year == selfComponents.year) {
        if (currentComponents.month == selfComponents.month) {
            return currentComponents.day == selfComponents.day + 1;
        }
        else if (currentComponents.month == selfComponents.month + 1)
        {
            if (selfComponents.month == 1 || selfComponents.month == 3 || selfComponents.month == 5 || selfComponents.month == 7 || selfComponents.month == 8 || selfComponents.month == 10 || selfComponents.month == 12) {
                return currentComponents.day == selfComponents.day - 30;
            }
            else if (selfComponents.month == 4 || selfComponents.month == 6 || selfComponents.month == 9 || selfComponents.month == 11)
            {
                return currentComponents.day == selfComponents.day - 29;
            }
            else
            {
                if ((selfComponents.year%4 == 0 && selfComponents.year%100 != 0) || selfComponents.year%400 == 0) {
                    return currentComponents.day == selfComponents.day - 28;
                }
                else
                {
                    return currentComponents.day == selfComponents.day - 27;
                }
            }
        }
    }*/
    
    //  方案二去掉时分秒，用日历对象比较
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return components.day == 1;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    //获得当前时间年月日
    NSDateComponents *currentComponents = [self takenDateComponents:[NSDate date]];
    
    //获得自己的年月日
    NSDateComponents *selfComponents = [self takenDateComponents:self];
    
    if (currentComponents.year == selfComponents.year) {
        return YES;
    }
    
    return NO;
}

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
