//
//  UpdateInformation.h
//  chihuoyangsheng
//
//  Created by BobZhang on 14-10-4.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol updateResult <NSObject>

- (void)updatedWithCallBack:(NSString*)zeroOrOne;

@end

@interface UpdateInformation : NSObject<UIAlertViewDelegate>
- (void)update;
@property (nonatomic,weak) id<updateResult> updater;
@end
