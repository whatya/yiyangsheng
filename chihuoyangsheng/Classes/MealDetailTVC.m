//
//  MealDetailTVC.m
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-7.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import "MealDetailTVC.h"
#import "MealService.h"
#import "DinnerPersonsViewController.h"
#import "GloblalSharedDataManager.h"

@interface MealDetailTVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *hotelAddressTextView;
@property (weak, nonatomic) IBOutlet UITextView *mealTimeTextView;
@property (weak, nonatomic) IBOutlet UITextView *unitPriceTextView;
@property (weak, nonatomic) IBOutlet UITextView *foodTypeTextView;
@property (weak, nonatomic) IBOutlet UITextView *mealDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *doctorAdviceTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIView *personList;

@end

@implementation MealDetailTVC

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)join:(id)sender
{
    [self.pinner startAnimating];
    [self validate];
}

- (void)validate
{
    NSString *gps = [WhereAmI shareLoaction].currentLocation;
    if ([gps isEqualToString:@"随便看看"]) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请登陆！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        [self.pinner stopAnimating];
        return;
    }
    
    NSString *customerID = [GloblalSharedDataManager sharedDataManager].customer.get_id;
    NSString *querStirng = [NSString stringWithFormat:@"id=%@",self.mealDetailDictionary[@"id"]];
    [MealService fetchDictionaryFromServerWithBaseUrl:@"getDinnerPartyById.ws"
                                          queryString:querStirng
                                             callBack:^(id dictionary) {
                                                 if ([dictionary isKindOfClass:[NSDictionary class]]) {
                                                     NSArray *persionsJoined = dictionary[@"dinnerPersons"];
                                                     BOOL isJoined = NO;
                                                     for (NSDictionary *per in persionsJoined){
                                                         NSString *customerIDInJoinedList = per[@"customerId"];
                                                         if ([customerIDInJoinedList isEqualToString:customerID]) {
                                                             isJoined = YES;
                                                             break;
                                                         }
                                                     }
                                                     if (isJoined) {
                                                         [self.pinner stopAnimating];
                                                         UIAlertView *joinedAlert = [[UIAlertView alloc]
                                                                                     initWithTitle:@"提示!"
                                                                                     message:@"不能加入自己发起的饭局或已经加入了的饭局"
                                                                                     delegate:nil
                                                                                     cancelButtonTitle:@"确定"
                                                                                     otherButtonTitles:nil, nil];
                                                         [joinedAlert show];
                                                         
                                                     }else{
                                                         [self sureJoing];
                                                     }
                                                 }
    }];

}



- (void)sureJoing
{
    NSString *customerID = [GloblalSharedDataManager sharedDataManager].customer.get_id;
    
    NSString *queryString = [NSString stringWithFormat:@"dinnerParty={'id':'%@','creater':{'customerId':'%@','customerType':'1'}}",self.mealDetailDictionary[@"id"],customerID];
    
    [MealService fetchDictionaryFromServerWithBaseUrl:@"saveDinnerParty.ws?"
                                          queryString:queryString
                                             callBack:^(NSString *success) {
                                                 [self.pinner stopAnimating];
                                                 if ([success isEqualToString:@"0"]) {
                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                                     message:@"加入成功！"
                                                                                                    delegate:self
                                                                                           cancelButtonTitle:@"确定"
                                                                                           otherButtonTitles:nil, nil];
                                                     [alert show];
                                                     
                                                 }else{
                                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                                     message:@"加入失败！"
                                                                                                    delegate:self
                                                                                           cancelButtonTitle:@"确定"
                                                                                           otherButtonTitles:nil, nil];
                                                     [alert show];
                                                 }
                                                 
                                                 
                                             }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    [backBtn setTitle:@"<返回"];
    [self.navigationController.navigationItem setBackBarButtonItem:backBtn];
    self.personList.layer.cornerRadius = 10;
    self.personList.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.personList.layer.borderWidth = 1.0f;
    self.title = @"饭局详情";
    [self updateUI];

}


- (void)setMealDetailDictionary:(NSDictionary *)mealDetailDictionary
{
    _mealDetailDictionary = mealDetailDictionary;
    [self updateUI];
}

- (void)updateUI
{
    self.joinButton.hidden = self.shouldHidePostButton;
    self.hotelNameLabel.text = self.mealDetailDictionary[@"hotelName"];
    self.hotelAddressTextView.text = self.mealDetailDictionary[@"hotelAddr"];
    self.mealTimeTextView.text = self.mealDetailDictionary[@"dinnerTime"];
    self.unitPriceTextView.text = [NSString stringWithFormat:@"%@", self.mealDetailDictionary[@"price"]];
    self.foodTypeTextView.text = self.mealDetailDictionary[@"cookStyle"];
    self.mealDescriptionTextView.text = self.mealDetailDictionary[@"detail"];
    //self.doctorAdviceTextView.text = self.mealDetailDictionary[@"dietitianAdvise"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DinnerPersonsViewController *dinnerPersonsVC = segue.destinationViewController;
    dinnerPersonsVC.dinnerID = self.mealDetailDictionary[@"id"];
}
@end
