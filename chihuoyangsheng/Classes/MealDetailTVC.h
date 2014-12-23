//
//  MealDetailTVC.h
//  yangsheng_version2
//
//  Created by BobZhang on 14-8-7.
//  Copyright (c) 2014年 BobZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealDetailTVC : UITableViewController

@property (nonatomic,strong) NSDictionary *mealDetailDictionary;
@property (nonatomic) BOOL shouldHidePostButton;

@end
