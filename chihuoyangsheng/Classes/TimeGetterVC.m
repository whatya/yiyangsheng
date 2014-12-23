//
//  TimeGetterVC.m
//  chihuoyangsheng
//
//  Created by BobZhang on 14-8-20.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "TimeGetterVC.h"

@interface TimeGetterVC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TimeGetterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES
completion:NULL];
}
- (IBAction)done:(id)sender {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:self.datePicker.date];
    self.dateString = date;
    [self performSegueWithIdentifier:@"dateBackUnwind" sender:self];
}

@end
