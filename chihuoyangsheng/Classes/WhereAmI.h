//
//  WhereAmI.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhereAmI : NSObject

@property (nonatomic,strong) NSString *currentLocation;
@property (nonatomic,strong) NSString *registLocation;
@property (nonatomic) BOOL isUpdating;
+ (WhereAmI*)shareLoaction;
@end
