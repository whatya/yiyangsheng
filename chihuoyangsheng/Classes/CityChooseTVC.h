//
//  CityChooseTVC.h
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-3.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityChooseTVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *cities;
@end
