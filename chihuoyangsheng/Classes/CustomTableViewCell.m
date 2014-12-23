//
//  CustomTableViewCell.m
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-9.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "SubItemModel.h"
#import "CustomTextView.h"

@implementation CustomTableViewCell

- (void)setItem:(SubItemModel *)item {
    
    if (_item != item) {
        _item = item;
        self.itemTextView.text = _item.itemContent;
    }
}

@end
