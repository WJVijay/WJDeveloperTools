//
//  NSDate+WJCategoryMethod.h
//  WJDemo
//
//  Created by Yuan Wang on 2018/1/30.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

@interface NSDate (WJCategoryMethod)

+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date

/**
 明天的日期
 
 @return 结果
 */
+ (NSDate *) dateTomorrow;


/**
 昨天的日期
 
 @return 结果
 */
+ (NSDate *) dateYesterday;


/**
 几天之后
 
 @param days 加几天
 @return 结果
 */
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;


/**
 几天之前
 
 @param days 日期
 @return 结果
 */
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;


/**
 几小时之后
 
 @param dHours 日期
 @return 结果
 */
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;


/**
 几小时之前
 
 @param dHours 日期
 @return 结果
 */
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;


/**
 几分钟之后
 
 @param dMinutes 日期
 @return 结果
 */
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;


/**
 几分钟之前
 
 @param dMinutes 日期
 @return 结果
 */
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;


/**
 字符串转nsdate
 
 @param datestr 日期字符串
 @param format 格式
 @return 结果
 */
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;

// Short string utilities

/**
 获取当前时间,并设置样式
 
 @param dateStyle dateStyle
 @param timeStyle timeStyle
 @return 结果
 */
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;


/**
 获取当前的时间,输出字符串
 
 @param format 输出字符串格式
 @return 结果字符串
 */
- (NSString *) stringWithFormat: (NSString *) format;



/**
 系统:NSDateFormatterStyle  转字符串
 */
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;


/**
 比较日期
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;


/**
 判断是今天
 
 @return 结果
 */
- (BOOL) isToday;


/**
 判断是明天
 
 @return 结果
 */
- (BOOL) isTomorrow;


/**
 判断是昨天
 
 @return 结果
 */
- (BOOL) isYesterday;


/**
 判断是否是同一周
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;


/**
 判断是同一周
 
 @return 结果
 */
- (BOOL) isThisWeek;


/**
 判断是下周
 
 @return 结果
 */
- (BOOL) isNextWeek;


/**
 判断是上周
 
 @return 结果
 */
- (BOOL) isLastWeek;


/**
 判断是同一月
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;


/**
 判断是这月
 
 @return 结果
 */
- (BOOL) isThisMonth;


/**
 判断是下月
 
 @return 结果
 */
- (BOOL) isNextMonth;


/**
 判断是上月
 
 @return 结果
 */
- (BOOL) isLastMonth;


/**
 判断是同一年
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isSameYearAsDate: (NSDate *) aDate;


/**
 判断是这一年
 
 @return 结果
 */
- (BOOL) isThisYear;


/**
 判断是下一年
 
 @return 结果
 */
- (BOOL) isNextYear;


/**
 判断是上一年
 
 @return 结果
 */
- (BOOL) isLastYear;


/**
 比较一个日期早于另一个日期
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isEarlierThanDate: (NSDate *) aDate;


/**
 比较一个日期晚于另一个日期
 
 @param aDate 日期
 @return 结果
 */
- (BOOL) isLaterThanDate: (NSDate *) aDate;


/**
 判断是否是将来的日期
 
 @return 结果
 */
- (BOOL) isInFuture;


/**
 判断是否是过去的日期
 
 @return 结果
 */
- (BOOL) isInPast;


// Date roles
/**
 判断是否是工作日
 
 @return 结果
 */
- (BOOL) isTypicallyWorkday;


/**
 判断是否是周末
 
 @return 结果
 */
- (BOOL) isTypicallyWeekend;

// Adjusting dates
/**
 几年后的日期年份
 
 @param dYears 加几年
 @return 结果
 */
- (NSDate *) dateByAddingYears: (NSInteger) dYears;


/**
 几年前的日期
 
 @param dYears 减几年
 @return 结果
 */
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;


/**
 几个月后的的日期
 
 @param dMonths 加几个月
 @return 结果
 */
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;


/**
 几个月前的日期
 
 @param dMonths 减几个月
 @return 结果
 */
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;


/**
 几天后的日期
 
 @param dDays 加几天
 @return 结果
 */
- (NSDate *) dateByAddingDays: (NSInteger) dDays;


/**
 几天前的日期
 
 @param dDays 减几天
 @return 结果
 */
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;


/**
 几个小时后的日期
 
 @param dHours 加几小时
 @return 结果
 */
- (NSDate *) dateByAddingHours: (NSInteger) dHours;


/**
 几小时前的日期
 
 @param dHours 减几小时
 @return 结果
 */
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;


/**
 几分钟后的日期
 
 @param dMinutes 加几分钟
 @return 结果
 */
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;


/**
 几分钟前的日期
 
 @param dMinutes 减几分钟
 @return 结果
 */
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;


// Date extremes
/**
 一天的开始时间
 
 @return 结果
 */
- (NSDate *) dateAtStartOfDay;


/**
 一天的结束时间
 
 @return 结果
 */
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
/**
 现在距离aDate之后多少分钟-> aDate>现在 为负数;< 现在则为正数
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) minutesAfterDate: (NSDate *) aDate;


/**
 现在距离aDate之前多少分钟
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;


/**
 现在距离aDate之后多少小时
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) hoursAfterDate: (NSDate *) aDate;


/**
 现在距离aDate之前多少小时
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;


/**
 现在距离aDate之后多少天
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) daysAfterDate: (NSDate *) aDate;


/**
 现在距离aDate之后多少天
 
 @param aDate 日期
 @return 结果
 */
- (NSInteger) daysBeforeDate: (NSDate *) aDate;


/**
 现在距离aDate多少天
 
 @param anotherDate 日期
 @return 结果
 */
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates

/**
 分解日期
 */
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;


/**
 yyyy-MM-dd 格式化输出当前时间
 
 @return 结果
 */
- (NSDate *)dateWithYMD;

/**
 格式化输出时间
 
 @param formatter 格式
 @return 结果
 */
- (NSDate *)dateWithFormatter:(NSString *)formatter;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 根据日期获取周几
 
 @param inputDate nsdate
 @return return 返回周几
 */
+ (NSString*)WJWeekdayStringFromDate:(NSDate*)inputDate;

#pragma mark: -格式化输出日期-
/**
 将日期格式化成字符串
 
 @param format 格式，例如 @"yyyy-MM-dd HH:mm:ss"
 */
- (NSString *)wj_stringWithFormat:(NSString *)format;

/**
 将日期格式化成字符串
 @param format 格式，例如 @"yyyy-MM-dd HH:mm:ss"
 */
- (NSString *)wj_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

/**
 以 ISO8601 格式化日期。例如： "2010-07-09T16:13:30+12:00"
 */
- (NSString *)wj_stringWithISOFormat;

/**
 从字符串解析出日期 (解析失败则返回nil)
 @param dateString 日期字符串，例如 "2010-07-09 16:13:30"
 @param format     日期格式，例如 "yyyy-MM-dd HH:mm:ss"
 */
+ (NSDate *)wj_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 从字符串解析出日期 (解析失败则返回nil)
 @param dateString 日期字符串，例如 "2010-07-09 16:13:30"
 @param format     日期格式，例如 "yyyy-MM-dd HH:mm:ss"
 */
+ (NSDate *)wj_dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

/**
 将 ISO8601 格式的字符串解析成日期。
 @param dateString 时间字符串，例如 "2010-07-09T16:13:30+12:00"
 */
+ (NSDate *)wj_dateWithISOFormatString:(NSString *)dateString;


@end
