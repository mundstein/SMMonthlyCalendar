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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = self.view.bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, w, w)];
    self.scrollView.pagingEnabled = YES;
    
    // testing
    NSArray *colors = @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor]];
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    NSDate *firstDate = [[NSDate date] dateBySubtractingMonths:(kNumberOfPages/2)];
    
    for (int i = 0; i<kNumberOfPages; i++) {
        SMCalendarMonthCollectionViewController *controller = [[SMCalendarMonthCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        controller.view.frame = CGRectMake(i*w, 0, w, w);
        controller.collectionView.backgroundColor = colors[i];
        controller.date = [firstDate dateByAddingMonths:i];
        [self.scrollView addSubview:controller.view];
        [controllers addObject:controller];
    }
    monthControllers = [NSArray arrayWithArray:controllers];
    self.scrollView.contentSize = CGSizeMake(kNumberOfPages * w, w);
    [self.view addSubview:self.scrollView];
}

-(void)viewWillLayoutSubviews {
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
