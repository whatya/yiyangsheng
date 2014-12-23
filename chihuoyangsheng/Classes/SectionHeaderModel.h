//
//  SectionHeaderModel.h
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-8.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//
/*
 content for every single section header
 */
#import <Foundation/Foundation.h>

@interface SectionHeaderModel : NSObject

@property (nonatomic, strong) NSString *name;      //体质名称
@property (nonatomic, strong) NSArray *subItems;   //体质名称对应的详细介绍数组

@end
