//
//  CookBookCell.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-2.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookBookcookbook.h"
#import "CookBookImageView.h"

@interface CookBookCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *cookBookName;
@property (nonatomic,weak) IBOutlet CookBookImageView *cookBookImageView;
@property (weak, nonatomic) IBOutlet UILabel *operaionTypeNameLabel;

@property (nonatomic,strong) CookBookcookbook *cookBook;

@end
