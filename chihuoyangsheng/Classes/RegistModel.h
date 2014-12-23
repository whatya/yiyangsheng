//
//  RegistModel.h
//  YangSheng-ios-3.0
//
//  Created by caoguochi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistModel : NSObject

@property (nonatomic, strong)NSString *methodKey;//custome里面的方法名称
@property (nonatomic, strong)NSString *nameString;//题目标签名称
@property (nonatomic, strong)NSString *answerString;//最终用户输入结果
@property (nonatomic, assign)NSInteger answerType;//题目输入类型

@property (nonatomic,strong) NSArray *answerOptions;//of string 问题的选项
@end
