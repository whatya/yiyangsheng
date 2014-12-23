//
//  MenuViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "WhereAmI.h"

@interface MenuViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegementControl;

@property (weak, nonatomic) IBOutlet UIDatePicker *chooseDate;

@end

@implementation MenuViewController

- (IBAction)switchDate:(UISegmentedControl *)sender
{

    int selectedIndex = (int)sender.selectedSegmentIndex;
    if (selectedIndex == 2) {
        [self exitHomePage];
    }else if (selectedIndex == 0){
        WhereAmI *location = [WhereAmI shareLoaction];
        if ([location.currentLocation isEqualToString:@"随便看看"]) {
            UIAlertView *visitor = [[UIAlertView alloc] initWithTitle:@"提示！"
                                                              message:@"登陆后可以查看完整信息!"
                                                             delegate:self cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"登陆", nil];
            [visitor show];
        }else{
            if ([[sender titleForSegmentAtIndex:0] isEqualToString:@"查看今日食谱"]) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                [formatter setDateFormat:@"yyyy-MM-dd"];
                
                [self.delegate updateDietryWithDateString:[formatter stringFromDate:[NSDate date]] andTimeMark:@"今日"];
            }else{
                
                NSDate * tomorrow = [[NSDate date] dateByAddingTimeInterval:24*60*60];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                [self.delegate updateDietryWithDateString:[formatter stringFromDate:tomorrow] andTimeMark:@"明日"];
            }
            
        }
    }else{
        WhereAmI *location = [WhereAmI shareLoaction];
        if ([location.currentLocation isEqualToString:@"随便看看"]) {
            UIAlertView *visitor = [[UIAlertView alloc] initWithTitle:@"提示！"
                                                              message:@"登陆后可以查看完整信息!"
                                                             delegate:self cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"登陆", nil];
            [visitor show];
        }else{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"MM-dd"];
            NSString *dateStringForUperLeftButton = [formatter2 stringFromDate:self.chooseDate.date];
            NSString *todayString = [formatter2 stringFromDate:[NSDate date]];
            if ([todayString isEqualToString:dateStringForUperLeftButton]) {
                dateStringForUperLeftButton = @"今日";
            }
            
            [self.delegate updateDietryWithDateString:[formatter stringFromDate:self.chooseDate.date]
                                          andTimeMark:dateStringForUperLeftButton];
        }
    }
    
}


- (void)exitHomePage
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate moveToLoginPage];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self exitHomePage];
    }
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.dateSegementControl setTitle:self.todayOrTomorrow forSegmentAtIndex:0];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setDay:-5];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.chooseDate setMaximumDate:maxDate];
    [self.chooseDate setMinimumDate:minDate];
}


-(void)setTodayOrTomorrow:(NSString *)todayOrTomorrow
{
    
    if ([todayOrTomorrow isEqualToString:@"今日"]) {
        _todayOrTomorrow = @"查看明日食谱";
        [self.dateSegementControl setTitle:@"查看明日食谱" forSegmentAtIndex:0];
    }else{
        _todayOrTomorrow = @"查看今日食谱";
        [self.dateSegementControl setTitle:@"查看今日食谱" forSegmentAtIndex:0];
    }
    
}


@end
