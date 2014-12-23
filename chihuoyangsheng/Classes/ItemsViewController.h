//
//  ItemsViewController.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-22.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController

@property (nonatomic, strong)NSArray *itemsArray;
@property (nonatomic, strong) void(^setAnswer)(NSString *);
@end
