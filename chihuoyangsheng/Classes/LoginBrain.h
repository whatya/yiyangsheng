//
//  LoginBrain.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginBrain : NSObject

@property (nonatomic,strong,readonly) NSString* loginErrorInformation;
@property (nonatomic,getter = isLoginSucceed,readonly) BOOL loginSucceed;

+ (instancetype)loginWithUser:(User*)user;

@end
