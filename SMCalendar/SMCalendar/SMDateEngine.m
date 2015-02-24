//
//  SMDateEngine.m
//  SMCalendar
//
//  Created by Sascha Mundstein on 10/26/13.
//  Copyright (c) 2013 Sascha Mundstein. All rights reserved.
//

#import "SMDateEngine.h"
#import "NSDate+SMUtilities.h"
#import <UIKit/UIKit.h>

@implementation SMDateEngine

+(NSInteger)numberOfDaysInMonth:(NSDate *)date {
    if (!date) {
        return 0;
    }
    //NSDateComponents *comp = [cal components:NSMonthCalendarUnit fromDate:date];
    return (NSUInteger)[CURRENT_CALENDAR rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

+(NSInteger)numberOfDaysInMonths:(NSInteger)months fromStartDate:(NSDate *)date {
    NSDate *endDate = [date dateByAddingMonths:months];
    return [endDate daysAfterDate:date];
}

+(NSInteger)weekdayOfFirstDayInMonth:(NSDate *)date {
    NSDateComponents *comp = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:[self firstDayInMonth:date]];
    return comp.weekday;
}

+(NSInteger)weekdayOfLastDayInMonth:(NSDate *)date {
    NSDateComponents *comp = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:[self lastDayInMonth:date]];
    return comp.weekday;
}

+(NSDate *)startingDateForMonthlyCalenderForDate:(NSDate *)date {
    NSDate *returnDate = [self firstDayInMonth:date];
    NSInteger delta = [self weekdayOfFirstDayInMonth:date] -1;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -delta;
    //return [returnDate dateByAddingTimeInterval:(-delta) * 60*60*24];
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:returnDate options:0];
}

+(NSInteger)numberOfRowsInMonthlyCalenderForDate:(NSDate*)date {
    
    NSInteger daysBefore = [self weekdayOfFirstDayInMonth:date] - 1;
    NSInteger daysAfter  = 7 - [self weekdayOfLastDayInMonth:date];
    NSInteger sum = daysBefore + [self numberOfDaysInMonth:date] + daysAfter;
    if (sum %7 != 0) {
        return 0;
    }
    else return sum;
}

+(NSDate *) firstDayInMonth:(NSDate *)date {
    NSCalendar *cal = CURRENT_CALENDAR;
    NSDateComponents *comp = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    comp.day = 1;
    return [cal dateFromComponents:comp];
}

+(NSDate *) lastDayInMonth:(NSDate *)date {
    NSCalendar *cal = CURRENT_CALENDAR;
    NSDateComponents *comp = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    comp.day = 0;
    comp.month+= 1;
    return [cal dateFromComponents:comp];
}

+(NSDate *)dateForItemAtIndexPath:(NSIndexPath *)indexPath withStartDate:(NSDate *)date {
    NSDate *monthDate = [date dateByAddingMonths:indexPath.section];
    NSDate *start = [self startingDateForMonthlyCalenderForDate:monthDate];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = indexPath.item;
    return [CURRENT_CALENDAR dateByAddingComponents:interval toDate:start options:0];
}

+(NSDate *)dateForItemAtIndex:(NSInteger)item withMonthDate:(NSDate *)date {
    NSDate *start = [self startingDateForMonthlyCalenderForDate:date];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = item;
    return [CURRENT_CALENDAR dateByAddingComponents:interval toDate:start options:0];
}

+(NSString *)dayStringForItemAtIndexPath:(NSIndexPath *)indexPath withStartDate:(NSDate *)date {
    NSDate *theDate = [self dateForItemAtIndexPath:indexPath withStartDate:date];
    NSDateComponents *comp = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:theDate];
    return [NSString stringWithFormat:@"%d", (int) comp.day];
}

+(NSString *)shortDayStringForDate:(NSDate *)date {
    static NSDateFormatter *shortFormatter = nil;
    if (!shortFormatter) {
        shortFormatter = [[NSDateFormatter alloc] init];
        shortFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEMMMd" options:0 locale:[NSLocale currentLocale]];
    }
    return [shortFormatter stringFromDate:date];
}

+(NSString *)longDayStringForDate:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterFullStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    }
    return [formatter stringFromDate:date];
}


@end
