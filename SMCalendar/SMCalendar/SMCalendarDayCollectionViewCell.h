//
//  SMCalendarDayCollectionViewCell.h
//  SMCalendar
//
//  Created by Sascha Mundstein on 24/02/15.
//  Copyright (c) 2015 Sascha Mundstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMCalendarDayCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *label;
@property (nonatomic) NSDate *date;
@property (nonatomic, assign) BOOL isCurrent;
@property (nonatomic, assign) BOOL isWeekday;

@end
