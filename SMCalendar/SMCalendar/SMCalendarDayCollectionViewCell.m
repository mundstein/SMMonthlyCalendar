//
//  SMCalendarDayCollectionViewCell.m
//  SMCalendar
//
//  Created by Sascha Mundstein on 24/02/15.
//  Copyright (c) 2015 Sascha Mundstein. All rights reserved.
//

#import "SMCalendarDayCollectionViewCell.h"
#import "NSDate+SMUtilities.h"

@implementation SMCalendarDayCollectionViewCell

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    CGSize s = self.bounds.size;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, s.width-10, s.height-10)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}

-(void)setDate:(NSDate *)date {
    _date = date;
    self.label.text = [NSString stringWithFormat:@"%li", date.day];
}

@end
