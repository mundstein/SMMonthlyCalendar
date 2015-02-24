//
//  SMDateEngine.h
//  SMCalendar
//
//  Created by Sascha Mundstein on 10/26/13.
//  Copyright (c) 2013 Sascha Mundstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMDateEngine : NSObject

+(NSInteger) numberOfDaysInMonth:(NSDate *)date;
+(NSInteger) numberOfDaysInMonths:(NSInteger)months fromStartDate:(NSDate *)date;

+(NSInteger) weekdayOfFirstDayInMonth:(NSDate *)date;
+(NSInteger) weekdayOfLastDayInMonth:(NSDate *)date;

// calendar layouts

+(NSDate *) startingDateForMonthlyCalenderForDate:(NSDate *)date;
+(NSInteger)numberOfRowsInMonthlyCalenderForDate:(NSDate*)date;
+(NSDate *)dateForItemAtIndexPath:(NSIndexPath *)indexPath withStartDate:(NSDate*)date;
+(NSDate *)dateForItemAtIndex:(NSInteger)item withMonthDate:(NSDate *)date;
+(NSString *) dayStringForItemAtIndexPath:(NSIndexPath *)indexPath withStartDate:(NSDate*)date;
+(NSString *) longDayStringForDate:(NSDate*)date;
+(NSString *) shortDayStringForDate:(NSDate*)date;

@end
