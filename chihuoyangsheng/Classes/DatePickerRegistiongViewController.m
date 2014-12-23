//
//  DatePickerRegistiongViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-4-12.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "DatePickerRegistiongViewController.h"


@interface DatePickerRegistiongViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerRegistiongViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    //[self.datePicker addTarget:self action:@selector(selechedADate:) forControlEvents:UIControlEventValueChanged];
}


- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectedDate = [dateFormatter stringFromDate:[self.datePicker date]];
    [self.delegate didPickedADateString:selectedDate];

}

@end
