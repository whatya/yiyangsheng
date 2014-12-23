//
//  CookBookCell.m
//  YangSheng-ios-3.0
//
//  Created by Bob Zhang on 14-4-2.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import "CookBookCell.h"

@implementation CookBookCell

- (void)setCookBook:(CookBookcookbook *)cookBook
{
    _cookBook = cookBook;
    self.cookBookName.text = cookBook.cookbookName;
    if (cookBook.image) {
        self.cookBookImageView.imageUrlString = [NSString stringWithFormat:@"http://115.28.170.201/yssl/uploadFiles/%@",cookBook.image];
    }
}

@end
