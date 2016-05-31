//
//  NSDate+QSP.h
//  MyWeibo
//
//  Created by     -MINI on 16/3/3.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QSP)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

@end
