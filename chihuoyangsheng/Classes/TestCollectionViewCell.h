//
//  TestCollectionViewCell.h
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-3-17.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"
@interface TestCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet TestView *questionView;

@end
