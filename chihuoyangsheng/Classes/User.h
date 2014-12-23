//
//  User.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-10.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *password;

+ (instancetype)UserWihtUserName:(NSString*)username password:(NSString*)password;


@end
