//
//  BaseFoodCell.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-3-27.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFoodCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodTitleName;
@property (nonatomic,strong) NSString *baseFoodId;
@property (nonatomic) BOOL highlight;

@end
