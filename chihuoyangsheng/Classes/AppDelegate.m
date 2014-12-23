//
//  AppDelegate.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "WelcomeBoardViewController.h"
#import "CustomerCustomerServiceImplServiceSoapBinding.h"
#import "RegistModel.h"
#import "GloblalSharedDataManager.h"


#import "AllDicsDictTypeServiceImplServiceSoapBinding.h"
#import "AllDicsdictType.H"
#import "DicDictServiceImplServiceSoapBinding.h"
#import "Dicdict.h"

#import "PrintObject.h"

#import "Util.h"

#import "MobileDB.h"
#import <MAMapKit/MAMapKit.h>

#import "LocationUtil.h"

#import "UpdateInformation.h"
#import "AddressUtil.h"

@interface AppDelegate ()<loginSuccessDelegate,SlidesEnded>
@property (nonatomic,strong) LocationUtil *locationUtil;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:111.0/255.0
                                                              green:78/255.0
                                                               blue:33/255.0
                                                               alpha:1]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [MAMapServices sharedServices].apiKey =@"0644e4290f985871b6a55f1ec1e0ab0d";
    //[[MobileDB dbInstance] fetchAllBaseFoodFromServer];
   //[[MobileDB dbInstance] fetchAllDictionaryFromServer];
   //[[MobileDB dbInstance] fetchAllAreaFromServer];
    //[[[AddressUtil alloc] init] fetchProAndCity];

    
    NSDictionary *userInfromation = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"];
    //如果是第一次登陆则显示欢迎界面
    
    if (userInfromation) {
        if ([userInfromation[@"customer"][@"loginName"] length] > 0 && [userInfromation[@"autoLogin"] isEqualToString:@"开"]) {
            [self dismissLoginVC:nil];
            WhereAmI *location = [WhereAmI shareLoaction];
            location.currentLocation = @"主页";
        }else{
            [self moveToLoginPage];
        }
    }else{
        UIStoryboard *wlsStoryBoard = [UIStoryboard storyboardWithName:@"MainBranch" bundle:nil];
        WelcomeBoardViewController *welcomeBoardVC =
        [wlsStoryBoard instantiateViewControllerWithIdentifier:@"WelcomeBoardVC"];
        self.window.rootViewController = welcomeBoardVC;
        welcomeBoardVC.delegate = self;

    }
    
    
    self.locationUtil = [[LocationUtil alloc] init];
    [self.locationUtil initLocationManager];
    [self.locationUtil startLocate];
   
     return YES;
}


#pragma mark -移除登陆界面跳转到主页
- (void)dismissLoginVC:(UIViewController*)loginVC
{
    UIStoryboard *wlsStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *mainVC = [wlsStoryBoard instantiateInitialViewController];
    self.window.rootViewController = mainVC;
}

#pragma mark -跳转到登陆界面
- (void)moveToLoginPage
{
    UIStoryboard *wlsStoryBoard = [UIStoryboard storyboardWithName:@"MainBranch" bundle:nil];
    LoginViewController *loginVC = [wlsStoryBoard instantiateViewControllerWithIdentifier:@"LoginVC"];
    loginVC.delegate = self;
    self.window.rootViewController = loginVC;
}


@end
