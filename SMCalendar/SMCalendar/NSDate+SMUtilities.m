//
//  NSDate+SMUtilities.m
//  WhatsNext
//
//  Created by Sascha Mundstein on 10/16/13.
//  Copyright (c) 2013 Top of Mind, All rights reserved.
//

#import "NSDate+SMUtilities.h"


@implementation NSDate (SMUtilities)

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [NOW dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [NOW dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = dHours;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:NOW options:0];
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = -dHours;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:NOW options:0];
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = dMinutes;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:NOW options:0];
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = -dMinutes;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:NOW options:0];
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) && 
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:NOW];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.weekOfYear != components2.weekOfYear) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < 60*60*24*7);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:NOW];
}

- (BOOL) isNextWeek
{
	NSDate *newDate = [NOW dateByAddingDays:7];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSDate *newDate = [NOW dateByAddingDays:-7];
	return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:NOW];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
	return [self isSameYearAsDate:NOW];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:NOW];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:NOW];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL) isInFuture
{
    return ([self isLaterThanDate:NOW]);
}

- (BOOL) isInPast
{
    return ([self isEarlierThanDate:NOW]);
}


#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

-(NSDate *)dateByAddingMonths:(NSInteger)dMonths {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = dMonths;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
}

-(NSDate *)dateBySubtractingMonths:(NSInteger)dMonths {
    return [self dateByAddingMonths:(dMonths * -1)];
}

-(NSDate *)dateByAddingWeeks:(NSInteger)dWeeks {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 7 * dWeeks;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
}

-(NSDate *)dateBySubtractingWeeks:(NSInteger)dWeeks {
    return [ self dateByAddingWeeks: (dWeeks * -1)];
}

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dDays;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = dHours;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = dMinutes;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateByAddingSeconds: (NSInteger) dSeconds {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second = dSeconds;
    return [CURRENT_CALENDAR dateByAddingComponents:components toDate:self options:0];
    
}
- (NSDate *) dateBySubtractingSeconds: (NSInteger) dSeconds {
    return [self dateByAddingSeconds: (dSeconds * -1)];
}

- (NSDate *) dateBySettingDay: (NSInteger) dDay {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.day = dDay;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *) dateBySettingMonth: (NSInteger) dMonth {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.month = dMonth;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

-(NSDate *)dateBySettingHour:(NSInteger) dHour {
    if (dHour < 0 || dHour > 23) { return self; }
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = dHour;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

-(NSDate *)dateBySettingMinute:(NSInteger) dMinute {
    if (dMinute < 0 || dMinute > 59) { return self; }
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.minute = dMinute;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateWithoutSeconds {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateBySettingHoursMinutesAndSeconds:(NSArray *)elements {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = [elements[0] integerValue] % 24;
    components.minute = [elements[1] integerValue] % 60;
    components.second = [elements[2] integerValue] % 60;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

-(NSDate *)firstDayInCurrentMonth {
    return [self dateBySettingDay:1];
}

-(NSDate *)lastDayInCurrentMonth {
    NSDate *firstOfNextMonth = [[self dateBySettingDay:1] dateByAddingMonths:1];
    return [firstOfNextMonth dateBySubtractingDays:1];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	return [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    return components.minute;
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    return -components.minute;
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    return components.hour;
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    return -components.hour;
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
	return components.day;
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
	return -components.day;
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

// Get durations independent from dates
+ (NSTimeInterval)secondDuration {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.second = 1;
    NSDate *temp = NOW;
    return -[temp timeIntervalSinceDate:[CURRENT_CALENDAR dateByAddingComponents:comps toDate:temp options:0]];
}

+ (NSTimeInterval)minuteDuration {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.minute = 1;
    NSDate *temp = NOW;
    return -[temp timeIntervalSinceDate:[CURRENT_CALENDAR dateByAddingComponents:comps toDate:temp options:0]];
}

+ (NSTimeInterval)hourDuration {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.hour = 1;
    NSDate *temp = NOW;
    return -[temp timeIntervalSinceDate:[CURRENT_CALENDAR dateByAddingComponents:comps toDate:temp options:0]];
}

+ (NSTimeInterval)dayDuration {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = 1;
    NSDate *temp = NOW;
    return -[temp timeIntervalSinceDate:[CURRENT_CALENDAR dateByAddingComponents:comps toDate:temp options:0]];
}

+ (NSTimeInterval)weekDuration {        NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = 7;
    NSDate *temp = NOW;
    return -[temp timeIntervalSinceDate:[CURRENT_CALENDAR dateByAddingComponents:comps toDate:temp options:0]];
}

+ (NSTimeInterval)yearDurationForYear:(NSInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = comps.month = 1;
    comps.second = comps.minute = comps.hour = 0;
    comps.year = year;
    NSDate *first = [CURRENT_CALENDAR dateFromComponents:comps];
    comps.year += 1;
    NSDate *next = [CURRENT_CALENDAR dateFromComponents:comps];
    return [next timeIntervalSinceDate:first];
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
	NSDate *newDate = [NOW dateByAddingMinutes:30];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekOfYear;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.year;
}

-(NSInteger) weekOfYear {
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekOfYear fromDate:self];
    return components.weekOfYear;
}

-(NSInteger)minutesSinceStartOfDay {
    return [CURRENT_CALENDAR ordinalityOfUnit:NSCalendarUnitMinute inUnit:NSCalendarUnitDay forDate:self] -1;
}

-(NSInteger)totalDaysInMonth {
    return [self.firstDayInCurrentMonth distanceInDaysToDate:self.lastDayInCurrentMonth] +1;
}

// Getting date component localized names

+(NSArray *)weekdayNames {
    return [self weekdayNamesWithFormatterString:@"EEEE"];
}

+(NSArray *)shortWeekdayNames {
    return [self weekdayNamesWithFormatterString:@"EEE"];
}

+(NSArray *)weekdayNamesWithFormatterString:(NSString *)dateFormat {
    NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
    weekdayFormatter.dateFormat = dateFormat;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2015; comps.month = 1;
    NSMutableArray *days = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        comps.day = 4 + i;
        NSDate *aDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
        [days addObject:[weekdayFormatter stringFromDate:aDate]];
    }
    return [NSArray arrayWithArray:days];
}


+(NSArray *)monthNames {
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    monthFormatter.dateFormat = @"LLLL";  // L = "Stand-alone month"
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2015; comps.month = 1; comps.day = 1;
    NSMutableArray *months = [NSMutableArray array];
    for (int i = 1; i < 13; i++) {
        comps.month = i;
        NSDate *aDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
        [months addObject:[monthFormatter stringFromDate:aDate]];
    }
    return [NSArray arrayWithArray:months];

}

@end
