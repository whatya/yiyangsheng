//
//  WhereAmI.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "WhereAmI.h"

@implementation WhereAmI

+ (WhereAmI*)shareLoaction
{
    static WhereAmI *_shareLoaction = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareLoaction = [[self alloc] init];
    });
    
    return _shareLoaction;
}

- (instancetype)init
{
    self = [super init ];
    if (self) {
        _currentLocation = @"注册页面";
        _registLocation = @"基本信息";
    }
    return self;
}

@end
