//
//  NSDate+SMUtilities.h
//  WhatsNext
//
//  Created by Sascha Mundstein on 10/16/13.
//  Copyright (c) 2013 Top of Mind, All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define NOW [NSDate date]


typedef NS_ENUM(NSInteger, WeekDays) {
    Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
};

@interface NSDate (SMUtilities)

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate; 
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingWeeks: (NSInteger) dWeeks;
- (NSDate *) dateBySubtractingWeeks: (NSInteger) dWeeks;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateByAddingSeconds: (NSInteger) dSeconds;
- (NSDate *) dateBySubtractingSeconds: (NSInteger) dSeconds;

- (NSDate *) dateBySettingDay: (NSInteger) dDay;
- (NSDate *) dateBySettingMonth: (NSInteger) dMonth;
- (NSDate *) dateBySettingHour: (NSInteger) dHour;
- (NSDate *) dateBySettingMinute:(NSInteger) dMinute;

- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateWithoutSeconds;

- (NSDate *) dateBySettingHoursMinutesAndSeconds:(NSArray *)elements;

- (NSDate *) firstDayInCurrentMonth;
- (NSDate *) lastDayInCurrentMonth;


// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger) distanceInDaysToDate:(NSDate *)anotherDate;

// Get durations independent from dates
+ (NSTimeInterval)secondDuration;
+ (NSTimeInterval)minuteDuration;
+ (NSTimeInterval)hourDuration;
+ (NSTimeInterval)dayDuration;
+ (NSTimeInterval)weekDuration;
+ (NSTimeInterval)yearDurationForYear:(NSInteger)year ;

// Decomposing dates
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
@property (readonly) NSInteger weekOfYear;

@property (readonly) NSInteger minutesSinceStartOfDay;
@property (readonly) NSInteger totalDaysInMonth;

// Getting date component localized names
+(NSArray *)weekdayNames;
+(NSArray *)shortWeekdayNames;
+(NSArray *)monthNames;

@end
