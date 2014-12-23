//
//  DietaryDatePickerVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-21.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "DietaryDatePickerVC.h"
#import "HomeDietaryTableViewController.h"
@interface DietaryDatePickerVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DietaryDatePickerVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)done:(UIButton *)sender
{
    UITabBarController *temp = (UITabBarController*)self.presentingViewController;
    UINavigationController *nav = temp.viewControllers[0];
    HomeDietaryTableViewController *home = nav.viewControllers[0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:self.datePicker.date];
    [home searchDietaryWithDateString:date];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
