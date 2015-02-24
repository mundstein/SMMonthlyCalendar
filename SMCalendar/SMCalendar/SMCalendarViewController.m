//
//  SMCalendarViewController.m
//  SMCalendar
//
//  Created by Sascha Mundstein on 24/02/15.
//  Copyright (c) 2015 Sascha Mundstein. All rights reserved.
//


#define kNumberOfPages 5

#import "SMCalendarViewController.h"
#import "SMCalendarMonthCollectionViewController.h"
#import "NSDate+SMUtilities.h"

@interface SMCalendarViewController () {
    NSArray *monthControllers;
}


@end

@implementation SMCalendarViewController

static NSDateFormatter *monthFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    monthFormatter = [[NSDateFormatter alloc] init];
    monthFormatter.dateFormat = @"MMMM";
    
    CGFloat w = self.view.bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, w, w)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator =
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    NSDate *firstDate = [[NSDate date] dateBySubtractingMonths:(kNumberOfPages/2)];
    
    for (int i = 0; i<kNumberOfPages; i++) {
        
        UILabel *monthLabel = [[UILabel alloc] initWithFrame: CGRectMake(i*w, 0, w, 20)];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        monthLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
        [self.scrollView addSubview:monthLabel];
        monthLabel.text = [monthFormatter stringFromDate:[firstDate dateByAddingMonths:i]];
        
        SMCalendarMonthCollectionViewController *controller = [[SMCalendarMonthCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        controller.view.frame = CGRectMake(i*w, 20, w, w);
        controller.collectionView.backgroundColor = [UIColor whiteColor];
        controller.date = [firstDate dateByAddingMonths:i];
        [self.scrollView addSubview:controller.view];
        [controllers addObject:controller];
    }
    monthControllers = [NSArray arrayWithArray:controllers];
    self.scrollView.contentSize = CGSizeMake(kNumberOfPages * w, w);
    self.scrollView.contentOffset = CGPointMake(kNumberOfPages/2*w, 0);
    [self.view addSubview:self.scrollView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
