//
//  SMCalendarMonthCollectionViewController.h
//  SMCalendar
//
//  Created by Sascha Mundstein on 24/02/15.
//  Copyright (c) 2015 Sascha Mundstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMCalendarMonthCollectionViewController : UICollectionViewController

@property (nonatomic) NSDate *date;
@property (nonatomic, strong) UILabel *monthLabel;

@end
