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

@interface SMCalendarViewController ()<UIScrollViewDelegate> {
    NSMutableArray *monthControllers;
}


@end

@implementation SMCalendarViewController

static NSDateFormatter *monthFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    monthFormatter = [[NSDateFormatter alloc] init];
    monthFormatter.dateFormat = @"MMMM";
    
    monthControllers = [NSMutableArray array];
    
    CGFloat w = self.view.bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, w, w)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator =
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    NSDate *firstDate = [[NSDate date] dateBySubtractingMonths:(kNumberOfPages/2)];
    
    for (int i = 0; i<kNumberOfPages; i++) {
        [self addMonthAtIndex:i withWidth:w andFirstDate:firstDate];
    }
    self.scrollView.contentSize = CGSizeMake(kNumberOfPages * w, w);
    self.scrollView.contentOffset = CGPointMake(kNumberOfPages/2*w, 0);
    [self.view addSubview:self.scrollView];
}

-(void)addMonthAtIndex:(int)i withWidth:(CGFloat)w andFirstDate:(NSDate*)firstDate {
    UILabel *monthLabel = [[UILabel alloc] initWithFrame: CGRectMake(i*w, 0, w, 20)];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    [self.scrollView addSubview:monthLabel];
    monthLabel.text = [monthFormatter stringFromDate:[firstDate dateByAddingMonths:i]];
    
    SMCalendarMonthCollectionViewController *controller = [[SMCalendarMonthCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    controller.view.frame = CGRectMake(i*w, 20, w, w);
    controller.collectionView.backgroundColor = [UIColor whiteColor];
    controller.date = [firstDate dateByAddingMonths:i];
    controller.monthLabel = monthLabel;
    [self.scrollView addSubview:controller.view];
    [monthControllers insertObject:controller atIndex:i];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offset = (NSInteger) scrollView.contentOffset.x / scrollView.bounds.size.width;
    scrollView.scrollEnabled = YES;
    
    // recenter:
    CGFloat w = self.view.bounds.size.width;
    SMCalendarMonthCollectionViewController *first = monthControllers.firstObject;

    if (offset == kNumberOfPages / 2 - 1) {

        NSDate *firstDate = [first.date dateBySubtractingMonths:1];
        SMCalendarMonthCollectionViewController *controller = monthControllers.lastObject;
        [controller.view removeFromSuperview];
        [controller.monthLabel removeFromSuperview];
        
        for (int i = 0; i<kNumberOfPages-1; i++) {
            SMCalendarMonthCollectionViewController *controller = monthControllers[i];
            UIView *label = controller.monthLabel;
            CGRect f = label.frame; f.origin.x += w; label.frame = f;
            UIView *month = controller.view;
            f = month.frame; f.origin.x += w;  month.frame = f;
        }
        
        [monthControllers removeLastObject];
        [self addMonthAtIndex:0 withWidth:w andFirstDate:firstDate];
        scrollView.contentOffset = CGPointMake(kNumberOfPages/2*w, 0);
    }
    
    else if (offset == kNumberOfPages / 2 +1) {
        
        NSDate *firstDate = [first.date dateByAddingMonths:1];
        SMCalendarMonthCollectionViewController *controller = monthControllers.firstObject;
        [controller.view removeFromSuperview];
        [controller.monthLabel removeFromSuperview];
        
        for (int i = 1; i<kNumberOfPages; i++) {
            SMCalendarMonthCollectionViewController *controller = monthControllers[i];
            UIView *label = controller.monthLabel;
            CGRect f = label.frame; f.origin.x -= w; label.frame = f;
            UIView *month = controller.view;
            f = month.frame; f.origin.x -= w;  month.frame = f;
        }
        [monthControllers removeObjectAtIndex:0];
        [self addMonthAtIndex:kNumberOfPages-1 withWidth:w andFirstDate:firstDate];
        scrollView.contentOffset = CGPointMake(kNumberOfPages/2*w, 0);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.scrollEnabled = NO;
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
