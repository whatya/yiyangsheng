//
//  RegistBasicViewController.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-16.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "RegistBasicViewController.h"
#import "CustomerCustomerServiceImplServiceSoapBinding.h"
#import "GloblalSharedDataManager.h"

@interface RegistBasicViewController ()
@property (strong, nonatomic) IBOutlet UIView *registRoundRectView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;
@property (weak, nonatomic) IBOutlet UILabel *pinnerLabel;

@end

@implementation RegistBasicViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.registRoundRectView.layer.cornerRadius = 10;
    self.registRoundRectView.layer.borderColor = [UIColor colorWithRed:108.0/255.0 green:41.0/255.0 blue:10.0/255.0 alpha:1].CGColor;
    self.registRoundRectView.layer.borderWidth = 1.0f;
    
    
}

//注册
- (IBAction)regist:(UIButton *)sender
{
    CustomerCustomerServiceImplServiceSoapBinding *customerService = [[CustomerCustomerServiceImplServiceSoapBinding alloc] init];
    
    NSString *usernameStr = _usernameTextField.text;
    NSString *passwordStr = _passwordTextField.text;
    
    if ([usernameStr isEqualToString:@""] || [passwordStr isEqualToString:@""]) {
        [self showMessage:@"账号或密码不能为空"];
    }else
    {
        [self.pinner startAnimating];
        self.pinnerLabel.hidden = NO;
        [customerService getCustomerByLoginNameAsync:usernameStr
                                            __target:self
                                           __handler:@selector(gotCustomer:)];
    }
}


- (void)gotCustomer:(id)obj
{
    [self.pinner stopAnimating];
    self.pinnerLabel.hidden = YES;
    Customercustomer *tempUser = obj;
    if (tempUser.loginName) {
        [self showMessage:@"用户名已存在"];
    }else
    {
        GloblalSharedDataManager *dataManager = [GloblalSharedDataManager sharedDataManager];
        dataManager.customer.loginName = self.usernameTextField.text;
        dataManager.customer.password  = self.passwordTextField.text;
        [self performSegueWithIdentifier:@"personalInformation" sender:self];
    }

}

//提示框
- (void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}



@end
