//
//  User.m
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)UserWihtUserName:(NSString *)username password:(NSString *)password
{
    User *user = [[User alloc] init];
    user.username = username;
    user.password = password;
    return user;
}

@end
