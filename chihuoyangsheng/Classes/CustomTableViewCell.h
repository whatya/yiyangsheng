//
//  CustomTableViewCell.h
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-9.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTextView;
@class SubItemModel;
#import "SubItemModel.h"
@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet CustomTextView *itemTextView;

@property (nonatomic) SubItemModel *item;

@end
