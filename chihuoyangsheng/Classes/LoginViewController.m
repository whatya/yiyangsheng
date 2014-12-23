//
//  LoginViewController.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginBrain.h"
#import "CustomerCustomerServiceImplServiceSoapBinding.h"
#import "GloblalSharedDataManager.h"
#import "WhereAmI.h"
#import "GuideSuggestionsServiceImplServiceSoapBinding.h"
#import "MealService.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pinner;

@property (weak, nonatomic) IBOutlet UILabel *autoLoginLabel;

@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@end

@implementation LoginViewController

- (IBAction)hideKeyBoard:(UITextField *)sender {

}

- (void)viewWillAppear:(BOOL)animated
{
    [WhereAmI shareLoaction].isUpdating = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    self.autoLoginLabel.text = [NSString stringWithFormat:@"自动登录:%@",manager.autoLogin ? manager.autoLogin : @"关"];
    self.autoLoginSwitch.on = manager.autoLogin && [manager.autoLogin isEqualToString:@"开"] ? YES : NO;
    if (manager.customer.loginName.length > 0) {
        self.usernameTextField.text = manager.customer.loginName;
        self.passwordTextField.text = manager.customer.password;
    }
    
    
}
- (IBAction)autoLogin:(UISwitch *)sender {
    GloblalSharedDataManager *manager = [GloblalSharedDataManager sharedDataManager];
    manager.autoLogin = sender.isOn && manager.autoLogin ? @"开" : @"关";
    self.autoLoginLabel.text = [NSString stringWithFormat:@"自动登录:%@",manager.autoLogin];
    [manager synchronousToUserDefaults];
}


- (IBAction)login:(UIButton *)sender
{
    if (self.usernameTextField
        .text.length > 0 && self.passwordTextField.text.length > 0) {
        CustomerCustomerServiceImplServiceSoapBinding *customerService =
        [[CustomerCustomerServiceImplServiceSoapBinding alloc] init];
        
        [customerService loginAsync:self.usernameTextField.text
                               arg1:self.passwordTextField.text
                           __target:self
                          __handler:@selector(didLogin:)];
        [self.pinner startAnimating];
    }
}

- (IBAction)buttomButtonClicked:(UIButton *)sender
{
    WhereAmI *loction = [WhereAmI shareLoaction];
    
    if (sender.tag == 997) {
        loction.currentLocation = @"注册页面";
        GloblalSharedDataManager *manager  = [GloblalSharedDataManager sharedDataManager];
        manager.customer = [[Customercustomer alloc] init];
        manager.healthRecord = [[CustomerhealthRecord alloc] init];
    }else{
        loction.currentLocation = @"随便看看";
    }
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
    
}
- (IBAction)dismissKeyBoard:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


- (void)didLogin:(NSString*)loginResult
{
    if ([loginResult isEqualToString:@"1"]) {
        CustomerCustomerServiceImplServiceSoapBinding *customerService =
        [[CustomerCustomerServiceImplServiceSoapBinding alloc] init];
        [customerService getCustomerByLoginNameAsync:self.usernameTextField.text __target:self __handler:@selector(gotCustomer:)];
        
    }else{
        [self.pinner stopAnimating];
        UIAlertView *errorAlertView = [[UIAlertView alloc]
                                       initWithTitle:@"登陆信息"
                                       message:@"用户名或密码错误"
                                       delegate:nil
                                       cancelButtonTitle:@"重新登陆"
                                       otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
}

- (void)gotCustomer:(Customercustomer*)customer
{
    GloblalSharedDataManager *manager  = [GloblalSharedDataManager sharedDataManager];
    manager.customer = nil;
    manager.healthRecord = nil;
    manager.customer = customer;
    manager.customer.constitutionName = [manager name_ForKey:manager.customer.constitution];
    WhereAmI *location = [WhereAmI shareLoaction];
    location.currentLocation = @"主页";
    [MealService fetchDictionaryFromServerWithBaseUrl:@"getCustomerInfo.ws" queryString:[NSString stringWithFormat:@"loginName=%@",customer.loginName] callBack:^(id dictionary) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary[@"healthRecord"] isKindOfClass:[NSDictionary class]]) {
                CustomerhealthRecord *healthRecord = [[CustomerhealthRecord alloc] init];
                [healthRecord setValuesForKeysWithDictionary:dictionary[@"healthRecord"]];
                manager.healthRecord = healthRecord;
            }

        }
          
        [manager synchronousToUserDefaults];
        [self.pinner stopAnimating];
        [self.delegate dismissLoginVC:self];

    }];
    
    }


@end
