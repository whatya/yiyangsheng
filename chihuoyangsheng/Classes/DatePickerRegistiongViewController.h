//
//  DatePickerRegistiongViewController.h
//  YangSheng-ios-3.0
//
//  Created by rimi on 14-4-12.
//  Copyright (c) 2014年 zhangbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
@protocol DatePicked <NSObject>

- (void)didPickedADateString:(NSString*)dateString;

@end

@interface DatePickerRegistiongViewController : UIViewController<FPPopoverControllerDelegate>

@property (weak,nonatomic) id<DatePicked> delegate;

@end
