//
//  LoginBrain.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "LoginBrain.h"


@interface LoginBrain ()

@property (nonatomic,strong,readwrite) NSString* loginErrorInformation;
@property (nonatomic,getter = isLoginSucceed,readwrite) BOOL loginSucceed;

@end

@implementation LoginBrain

+ (instancetype)loginWithUser:(User *)user
{
    //CustomerServiceImplServiceSoapBinding *custmerService = [[CustomerServiceImplServiceSoapBinding alloc] init];
    
    if ([user.password isEqualToString:@"admin"] && [user.username isEqualToString:@"admin"]) {
        return [[LoginBrain alloc] initWithLoginErrorInformation:nil longResult:YES];
    }else{
        return [[LoginBrain alloc] initWithLoginErrorInformation:@"用户名或密码错误！" longResult:NO];
    }
}

- (instancetype)initWithLoginErrorInformation:(NSString*)loginErrorInfomation
                                   longResult:(BOOL)loginSucceed
{
    self = [super init];
    if (self) {
        _loginErrorInformation = loginErrorInfomation;
        _loginSucceed = loginSucceed;
    }
    return self;
}

@end
