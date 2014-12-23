//
//  BaseFoodHeader.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-27.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFoodHeader : UICollectionReusableView

@property (nonatomic,weak) IBOutlet UILabel *foodTypeLabel;
@property (nonatomic)NSInteger totalSubCounts;

@end
